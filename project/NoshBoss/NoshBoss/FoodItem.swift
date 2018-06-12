//
//  FoodItem.swift
//  NoshBoss
//
//  Created by Bevin Tang on 5/29/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import Foundation

class FoodItem{
    var name = String()
    var timeLeft = Int()
    var expDate = String();

    init(name : String, timeLeft : Int, expDate : String) {
        self.name = name
        self.timeLeft = timeLeft
        self.expDate = expDate
    }
    
    convenience init() {
        self.init(name:"N/A", timeLeft:0, expDate:"0/0/0")
    }

}
