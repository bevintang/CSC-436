//
//  Schools.swift
//  FireBaseStore
//
//  Created by Bevin Tang on 5/22/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import Foundation

struct Schools: Codable {
    var schoolsArr : [School]
    
    private enum CodingKeys: String, CodingKey {
        case schoolsArr = "schools"
    }
}
