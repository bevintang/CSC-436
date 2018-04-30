//
//  ViewController.swift
//  Lab4
//
//  Created by Bevin Tang on 4/16/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {
    // Labels
    @IBOutlet weak var titleEditField: UITextField!
    @IBOutlet weak var authorEditField: UITextField!
    @IBOutlet weak var ratingEditField: UITextField!
    @IBOutlet weak var reviewEditField: UITextField!
    
    var bookFromTable = Book(title: "foo", author : "foo", rating: 69.0, review: "foo");
    var rowNum = -1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        titleEditField.placeholder = bookFromTable.title;
        authorEditField.placeholder = bookFromTable.author;
        ratingEditField.placeholder = String(bookFromTable.rating);
        reviewEditField.placeholder = bookFromTable.review;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Text Field Operations
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch (textField){
        case titleEditField:
            bookFromTable.title = textField.text ?? bookFromTable.title
            break
        case authorEditField:
            bookFromTable.author = textField.text ?? bookFromTable.author
            break
        case ratingEditField:
            bookFromTable.rating = Double(textField.text ?? String(bookFromTable.rating))!
            break
        case reviewEditField:
            bookFromTable.review = textField.text ?? bookFromTable.review
            break
        default:
            break;
        }
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "saveChanges"){
            let destVC = segue.destination as? VCwithTable
            destVC?.newBook = self.bookFromTable
            destVC?.changedRow = self.rowNum;
        }
    }

}

