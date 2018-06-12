//
//  TableViewController.swift
//  NoshBoss
//
//  Created by Bevin Tang on 5/29/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var foodItems = [FoodItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodItems.append(FoodItem(name: "Bananas", timeLeft: 2, expDate: "0/0/0"))
        
        print(foodItems.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodItemCell", for: indexPath) as? TableViewCell

        // Configure the cell...
        let thisNosh = foodItems[indexPath.row]
        cell?.nameLabel.text = thisNosh.name
        cell?.timeLeftLabel.text = "Expires in " + String(thisNosh.timeLeft) + " Days"

        return cell!
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "edit") {
            let destVC = segue.destination as? EditViewController
            let cellRow = tableView.indexPathForSelectedRow!.row
            destVC?.itemFromTable = foodItems[cellRow]
            destVC?.rowFromTable = cellRow
        }
    }
    
    @IBAction func unwindToTableFromAdd(sender: UIStoryboardSegue) {
        if (sender.identifier == "add"){
            print("Unwind from add button")
        }
        else if (sender.identifier == "addCancel"){
            print("Unwind from cancel button")
        }
    }

}
