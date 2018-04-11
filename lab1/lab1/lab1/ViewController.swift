//
//  ViewController.swift
//  lab1
//
//  Created by Bevin Tang on 4/2/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Labels
    @IBOutlet weak var joke: UILabel!
    @IBOutlet weak var face: UIImageView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var squareRoot: UIButton!
    
    // Button actions
    @IBAction func jokePressed(_ sender: UIButton) {
        joke.text = "snowballs."
    }
    @IBAction func facePressed(_ sender: UIButton) {
        face.isHidden = false
    }
    @IBAction func solvePiPressed(_ sender: UIButton) {
        if (loadIndicator.isAnimating){
            squareRoot.titleLabel!.text = "Give up"
            loadIndicator.stopAnimating()
        }
        else {
            squareRoot.titleLabel!.text = "Solve the Square-Root of Pi"
            loadIndicator.startAnimating()
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

