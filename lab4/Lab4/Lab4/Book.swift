//
//  Book.swift
//  Lab4
//
//  Created by Bevin Tang on 4/16/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import Foundation

class Book : NSObject, NSCoding {
    // Properties
    var title = String();
    var author = String();
    var rating = Double();
    var review = String();
    
    init (title : String, author : String, rating : Double, review : String){
        self.title = title;
        self.author = author;
        self.rating = rating;
        self.review = review;
    }
    
    // Interface Functions
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey:"title")
        aCoder.encode(author, forKey:"author")
        aCoder.encode(rating, forKey:"rating")
        aCoder.encode(review, forKey:"review")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        author = aDecoder.decodeObject(forKey: "author") as! String
        rating = aDecoder.decodeDouble(forKey: "rating")
        review = aDecoder.decodeObject(forKey: "review") as! String
    }
    
    override var description : String {
        get {
            return "Title: \(title)  Author: \(author)  Rating: \(rating)"
        }
    }
    
}
