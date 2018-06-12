//
//  DetailViewController.swift
//  FireBaseStore
//
//  Created by Bevin Tang on 5/23/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var school = SchoolObject(name: "", city: "", state: "", zip: "", contact_email: "", latitude: 0.0, longitude: 0.0)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = school.name
        cityLabel.text = school.city
        stateLabel.text = school.state
        zipLabel.text = school.zip
        emailLabel.text = "contact:\t" + checkEmpty(emptyString : school.contact_email)
    }
    
    func checkEmpty(emptyString : String) -> String {
        var myString = emptyString
        if myString == "" {
            myString = "N/A"
        }
        return myString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
