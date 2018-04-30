//
//  VCwithTable.swift
//  Lab4
//
//  Created by Bevin Tang on 4/23/18.
//  Copyright © 2018 CalPoly Computer Science. All rights reserved.
//

import UIKit

class VCwithTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // File management
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("savedReviews")
    
    // Class vars
    var books = [Book]();
    var changedRow = -1;
    var newBook = Book(title: "", author: "", rating: 0.0, review: "")
    var ourDefaults = UserDefaults.standard
    var dateFormatter = DateFormatter()
    
    // Labels
    @IBOutlet weak var reviewTV: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        // init with persisted data, if any (Randy Scovil c 2015)
//        if let lastUpdate = ourDefaults.object(forKey: "lastUpdate") as? Date {
//
//            let updateString = dateFormatter.string(from: lastUpdate)
//            let dialogString = "Data was last updated:\n\(updateString)"
//
//            let dialog = UIAlertController(title: "Data Restored", message: dialogString, preferredStyle: .alert)
//            
//            let action = UIAlertAction(title: "Go Away", style: .cancel, handler: nil)
//            dialog.addAction(action)
//
//            present(dialog, animated: true, completion: nil)
//        }
        if let tempArr = NSKeyedUnarchiver.unarchiveObject(withFile: VCwithTable.archiveURL.path) as?
            [Book] {
            books = tempArr
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ** Table View Functions ** //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookTVC
        
        // Configure the cell...
        let thisBook = books[indexPath.row]
        cell?.titleCell.text = thisBook.title;
        cell?.authorCell.text = thisBook.author;
        cell?.ratingCell.text = String(thisBook.rating);
        cell?.reviewCell.text = thisBook.review;
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        reviewTV.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            books.remove(at: (indexPath as NSIndexPath).row)
            reviewTV.deleteRows(at: [indexPath], with: .fade)
            updatePersistentStorage()
        }
    }

    

    // ** Navigation/Segue Functions ** //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showDetails"){
            let destVC = segue.destination as? EditViewController
            let selectedIndexPath = reviewTV.indexPathForSelectedRow
            destVC?.bookFromTable = books[(selectedIndexPath?.row)!]
            destVC?.rowNum = selectedIndexPath!.row
        }
        
    }
    
    func updatePersistentStorage() {
        // persist data
        NSKeyedArchiver.archiveRootObject(books, toFile: VCwithTable.archiveURL.path)
        
        // timestamp last update
        ourDefaults.set(Date(), forKey: "lastUpdate")
    }
    
    @objc func insertNewObject(_ sender: AnyObject) {
        let newTitle = "Foo"
        books.append(Book(title: newTitle, author: "Foobar", rating: 4.2, review: "BarfooBar"))
        
        self.reviewTV.reloadData()
        
        updatePersistentStorage()
    }
    
    @IBAction func unwindToTable(sender: UIStoryboardSegue) {
    }

    @IBAction func unwindToTableFromSave(sender: UIStoryboardSegue) {
        if (sender.identifier == "addNewReview"){
            books.append(newBook)
        }
        else if (sender.identifier == "saveChanges"){
            print(changedRow)
            books[changedRow] = newBook
        }
        
        self.reviewTV.reloadData()
        updatePersistentStorage()
    }
}
