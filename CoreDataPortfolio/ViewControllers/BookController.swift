//
//  BookController.swift
//  CoreDataPortfolio
//
//  Created by Test on 4/22/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//

import UIKit
import CoreData

class BookController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var managedObjContext:NSManagedObjectContext! //context or delegate to managed entities
    var data = [Books]()     //where Books data is held
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadData()
    }
    
    func loadData() {
        //collect/fetch data from persistentent entity
        let dataRequest:NSFetchRequest<Books> = Books.fetchRequest()
        do {
            data = try self.managedObjContext.fetch(dataRequest)
            self.tableView.reloadData()
        } catch {
            print("Load failed \(error.localizedDescription)")
        }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //corresponds to height of cells in Table View
        return 150
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of rows in data source
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        let row = data[indexPath.row]
        cell.title.text = row.title
        cell.author.text = row.author
        cell.date.text = row.date
        return cell
    }
    
    @IBAction func addBooks(_ sender: Any) {
        createBookItem()
    }
        func createBookItem () {
            let BooksItem = Books(context: managedObjContext)
            let inputAlert = UIAlertController(title: "New Books", message: "Enter Book Attributes", preferredStyle: .alert)
            inputAlert.addTextField { (textfield:UITextField) in textfield.placeholder = "Book" }
            inputAlert.addTextField { (textfield:UITextField) in textfield.placeholder = "Author" }
            inputAlert.addTextField { (textfield:UITextField) in textfield.placeholder = "Year Published" }
            inputAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action:UIAlertAction ) in
                let bookTextField = inputAlert.textFields?.first
                let authorTextField = inputAlert.textFields?[1]
                let yearTextField = inputAlert.textFields?.last
                if bookTextField?.text != "" && authorTextField?.text != "" && yearTextField?.text != "" {
                    BooksItem.title = inputAlert.textFields?.first?.text! as! String
                    BooksItem.author = inputAlert.textFields?[1].text! as! String
                    BooksItem.date = inputAlert.textFields?.last?.text! as! String
                    do {
                        try self.managedObjContext.save()
                        self.loadData()
                    } catch {
                        print("Save failed \(error.localizedDescription)")
                    }
                }
            }))
            //cancel block in dialog
            inputAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(inputAlert, animated: true, completion: nil)
        }
        
    }
    

