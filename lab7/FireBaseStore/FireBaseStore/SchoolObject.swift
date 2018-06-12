//
//  SchoolObject.swift
//  FireBaseStore
//
//  Created by Bevin Tang on 5/23/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import MapKit

class SchoolObject : NSObject, MKAnnotation {
    var name : String
    var city : String
    var state : String
    var zip : String
    var contact_email : String
    var latitude : Double
    var longitude : Double
    let ref : DatabaseReference?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return city
    }
    
    init(name: String, city: String, state: String, zip : String, contact_email : String, latitude : Double, longitude : Double) {
        self.name = name
        self.city = city
        self.state = state
        self.zip = zip
        self.contact_email = contact_email
        self.latitude = 0
        self.longitude = 0
        
        ref = nil
        
        super.init()
    }
    
    init(key: String, snapshot: DataSnapshot) {
        name = key

        let snapvalues = snapshot.value as! [String : AnyObject]
        let snapDictionary = snapvalues[key] as! [String:AnyObject]
        
        city = snapDictionary["city"] as? String ?? "N/AAA"
        state = snapDictionary["state"] as? String ?? "N/AAA"
        zip = snapDictionary["zip"] as? String ?? "N/AAA"
        contact_email = snapDictionary["contact_email"] as? String ?? "N/AAA"
        latitude = snapDictionary["latitude"] as? Double ?? 35.300066
        longitude = snapDictionary["longitude"] as? Double ?? -120.662065
        
        ref = snapshot.ref
        
        super.init()
    }
}
