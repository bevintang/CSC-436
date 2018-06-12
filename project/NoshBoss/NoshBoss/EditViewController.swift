//
//  EditViewController.swift
//  NoshBoss
//
//  Created by Bevin Tang on 5/29/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var noshTextField: UITextField!
    @IBOutlet weak var expTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    var itemFromTable = FoodItem()
    var rowFromTable = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        noshTextField.placeholder = itemFromTable.name
        expTextField.placeholder = itemFromTable.expDate
        timeTextField.placeholder = String(itemFromTable.timeLeft) + " days"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

