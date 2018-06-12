//
//  ViewController.swift
//  FireBaseStore
//
//  Created by Bevin Tang on 5/16/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation
import GeoFire

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    // JSON/Firebase Vars
    let schoolsSource = "https://code.org/schools.json"
    var schoolRoot : DatabaseReference?
    var codingSchools : Schools?
    var schoolsList : [School] = [School()]
    
    // GeoFire Vars
    var geoFire : GeoFire?
    var geoRoot : DatabaseReference?
    var regionQuery : GFRegionQuery?
    let locationManager = CLLocationManager()
    let cscBuilding = CLLocationCoordinate2D(latitude: 35.300066, longitude: -120.662065)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enables local offline persistence
        // This must precede getting the database reference
        Database.database().isPersistenceEnabled = true
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously(completion: { (user: User?, error: Error?) in
            })
        }
        
        // Set database reference
        schoolRoot = Database.database().reference(withPath: "Schools")
        schoolRoot?.keepSynced(true)
        
        // Retrieve data from JSON database
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: schoolsSource)!)
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            // TODO: DOESN'T EVEN REACH THIS IF LET
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let codableSchoolsService = try decoder.decode(Schools.self, from: data)
                    
                    self.codingSchools = codableSchoolsService
                    
                    //DispatchQueue.main.async {
                    // Add entries into the database
                    for entry in self.codingSchools!.schoolsArr {
                        if (entry.zip != nil && entry.zip!.prefix(2) == "93"){
                            self.addSchool(newSchool: self.replaceSymbols(school: entry))
                        }
                    }
                    //}
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()

        // Initialize GeoFire Vars
        configureLocationManager()
        geoFire = GeoFire(firebaseRef: Database.database().reference().child("GeoFire"))

        // Add Firebase Locations to GeoFire
        oneTimeInit()

        // Setup MapView
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.55)
        let newRegion = MKCoordinateRegion(center: cscBuilding, span: span)
        mapView.setRegion(newRegion, animated: true)
    }
    
    func configureLocationManager() {
        CLLocationManager.locationServicesEnabled()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = 1.0
        locationManager.distanceFilter = 100.0
        locationManager.startUpdatingLocation()
    }
    
    func oneTimeInit() {
        schoolRoot?.queryOrdered(byChild: "Schools").observe(.value, with:
            { snapshot in

                var newSchools = [SchoolObject]()

                for item in snapshot.children {
                    print(String((item as AnyObject).key))
                    newSchools.append(SchoolObject(key: (item as AnyObject).key, snapshot: snapshot))
                }

                for next in newSchools {
                    self.geoFire?.setLocation(CLLocation(latitude:next.latitude,longitude:next.longitude), forKey: next.name)
                }
        })
    }
    
    /** Look into the name of the school and replace all periods with spaces **/
    func replaceSymbols(school : School) -> School {
        var newSchool = school
        
        // Check if school.name is nil
        if var newName = school.name {
            newName = newName.replacingOccurrences(of: ".", with: " ")
            newSchool.name = newName
        }
        else {
            newSchool.name = "N/A"
        }
        return newSchool
    }
    
    /** Append school to local list and add it to Firebase **/
    func addSchool(newSchool : School) {
        schoolsList.append(newSchool)
    
        // add to Firebase
        let newStandRef = schoolRoot?.child(newSchool.name ?? "N/A")
        newStandRef?.setValue(newSchool.toAnyObject())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ------- Map View Functions ------------ //
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapView.removeAnnotations(mapView.annotations)
        
        updateRegionQuery()
    }
    
    func updateRegionQuery() {
        if let oldQuery = regionQuery {
            oldQuery.removeAllObservers()
        }

        regionQuery = geoFire?.query(with: mapView.region)

        regionQuery?.observe(.keyEntered, with: { (key, location) in
            self.schoolRoot?.queryOrderedByKey().queryEqual(toValue: key).observe(.value, with:
            {snapshot in

                let newSchool = SchoolObject(key:key, snapshot:snapshot)
                self.addSchoolAnnotation(mapSchool : newSchool)
            })
        })
        
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    func addSchoolAnnotation(mapSchool : SchoolObject) {
        DispatchQueue.main.async {
            self.mapView.addAnnotation(mapSchool)
            print("\tNumber of Annotations in this region: \(self.mapView.annotations.count) @ \(clock())")
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.setRegion(MKCoordinateRegionMake((mapView.userLocation.location?.coordinate)!, MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is SchoolObject {
            let annotationView = MKPinAnnotationView()
            annotationView.pinTintColor = .red
            annotationView.annotation = annotation
            annotationView.canShowCallout = true
            annotationView.animatesDrop = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "showDetails", sender: view.annotation!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // add conditional
        if segue.identifier == "showDetails" {
            if let selectedSchool = sender as? SchoolObject {
                let destVC = segue.destination as! DetailViewController
                destVC.school = selectedSchool
            }
        }
    }


}

