//
//  BookTableViewController.swift
//  Lab4
//
//  Created by Bevin Tang on 4/16/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    var books = [Book]();
    @IBOutlet weak var reviewsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //books = books.sorted(by: {$0.title < $1.title})
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
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookTVC

        // Configure the cell...
        let thisBook = books[indexPath.row]
        cell?.titleCell.text = thisBook.title;
        cell?.authorCell.text = thisBook.author;
        cell?.ratingCell.text = String(thisBook.rating);
        cell?.reviewCell.text = thisBook.review;
        
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
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showDetails"){
            let destVC = segue.destination as? EditViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            destVC?.bookFromTable = books[(selectedIndexPath?.row)!]
        }
    }

}
