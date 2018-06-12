//
//  School.swift
//  FireBaseStore
//
//  Created by Bevin Tang on 5/22/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import Foundation
import Firebase
import GeoFire

struct School : Codable {
    var name : String?
    var city : String?
    var state : String?
    var zip : String?
    var contact_email : String?
    var latitude : Double?
    var longitude : Double?
    
    init() {
        name = "N/A"
        city = "N/A"
        state = "N/A"
        zip = "N/A"
        contact_email = "N/A"
        latitude = 0.0
        longitude = 0.0
    }
    
    func toAnyObject() -> Any {
        return [
            "name" : name!,
            "city" : city ?? "N/A",
            "state" : state ?? "N/A",
            "zip" : zip ?? "N/A",
            "contact_email" : contact_email ?? "N/A",
            "latitude" : latitude ?? 0.0,
            "longitude" : longitude ?? 0.0
        ]
    }
}
