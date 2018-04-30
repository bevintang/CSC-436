//
//  AddViewController.swift
//  Lab4
//
//  Created by Bevin Tang on 4/26/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    // Labels
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleAddField: UITextField!
    @IBOutlet weak var authorAddField: UITextField!
    @IBOutlet weak var ratingAddField: UITextField!
    @IBOutlet weak var reviewAddField: UITextField!
    
    // Vars
    var newBook = Book(title: "", author: "", rating: 0.0, review: "");
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Text Field Operations
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch (textField){
        case titleAddField:
            newBook.title = textField.text ?? ""
            break
        case authorAddField:
            newBook.author = textField.text ?? ""
            break
        case ratingAddField:
            newBook.rating = Double(textField.text ?? "0.0")!
            break
        case reviewAddField:
            newBook.review = textField.text ?? ""
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
        if (segue.identifier == "addNewReview"){
            let destVC = segue.destination as? VCwithTable
            destVC?.newBook = self.newBook
        }
    }
    
    
}

