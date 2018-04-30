//
//  ViewController.swift
//  Lab3
//
//  Created by Bevin Tang on 4/11/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /* Outlets */
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var restWheel: UIPickerView!
    
    /* Dictionary Handling */
    var restaurants:[String:[String]] = [:];
    var cities:[String] = [];
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0){
            return restaurants.keys.count;
        }
        else if (component == 1) {
            let curCity = cities[pickerView.selectedRow(inComponent: 0)]
            return restaurants[curCity]!.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0){
            return cities[row]
        }
        else if (component == 1){
            let curCity = cities[pickerView.selectedRow(inComponent: 0)]
            return restaurants[curCity]!.sorted()[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Prevent out of bounds indexing
        if (component == 0){
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
        }
        // Change label
        printLabel()
    }
    
    func printLabel() {
        let curCity = cities[restWheel.selectedRow(inComponent: 0)]
        let curRestaurants = restaurants[curCity]!
        let curRestRow = restWheel.selectedRow(inComponent: 1)
        restLabel.text = curCity + "-" + curRestaurants[curRestRow]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        importRestaurants()
        printLabel()
        //restLabel.text = cities[0] + "-" + restaurants[cities[0]]![0]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /* Read  information from Restaurants.plist */
    func importRestaurants() {
        if let url = Bundle.main.url(forResource: "Restaurants", withExtension: "plist"){
            do {
                let data = try Data(contentsOf:url)
                let tempDict = try
                    PropertyListSerialization.propertyList(
                        from: data, options: [], format: nil)
                    as! [String:[String]]
                // assign class variable to tempDict
                restaurants = tempDict
                cities = [String](tempDict.keys).sorted()
                
                for city in cities {
                    restaurants[city] = restaurants[city]!.sorted()
                }
            }
            catch {
                print(error)
            }
        }
    }
}

