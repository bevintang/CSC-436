//
//  ViewController.swift
//  Lab2
//
//  Created by Bevin Tang on 4/6/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var segmentLabel: UILabel!
    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sliderLabel: UILabel!
    
    // Text Field Operations
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldLabel.text = textField.text
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
    // Segment Operations
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        let segIndex = sender.selectedSegmentIndex;
        segmentLabel.text = sender.titleForSegment(at: segIndex)
    }
    
    // Slider Operations
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderLabel.text = String(sender.value)
        if (sender.value < 33){
            sliderLabel.textColor = .red
        }
        else if (sender.value > 66.9999){
            sliderLabel.textColor = .green
        }
        else {
            sliderLabel.textColor = .yellow
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

