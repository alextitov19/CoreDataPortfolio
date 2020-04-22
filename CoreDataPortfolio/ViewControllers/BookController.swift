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
        var data = [Books]()     //where Program Books data is held
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Image/Title for Navigation
    //       let backgroundImage = UIImage(named: "CDP_BooksWallpaper.png")
    //       let imageView = UIImageView(image: backgroundImage)
    //       self.tableView.backgroundView = imageView
            let iconImageView = UIImageView(image: UIImage(named: "Bookss"))
            self.navigationItem.titleView = iconImageView
            //setup context or delegate for fetching, retrieving, storing data
            managedObjContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            //populate Table View
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
            
            //cell refererence in Table View
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookTableViewCell
            
            //row or object in data source
            let row = data[indexPath.row]
            
            //load Table View from core data attributes
            cell.title.text = row.title
            cell.author.text = row.author
            cell.date.text = row.date
            return cell
        }
        
        //Add Programming Books Action for add (+)
        @IBAction func addBooks(_ sender: Any) {
            //properties
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                picker.dismiss(animated: true, completion: {
                    self.createProjLangItem(with: image)
                })
            }
        }
        
        //Dialog and Data operations for adding a Programming Books
        func createProjLangItem (with image:UIImage) {
            let BooksItem = Books(context: managedObjContext)
            
            //preparing image for save
            
            //inputAlert is dialog for new Programming Books entry
            let inputAlert = UIAlertController(title: "New Books", message: "Enter Book Attributes", preferredStyle: .alert)
            inputAlert.addTextField { (textfield:UITextField) in textfield.placeholder = "Book" }
            inputAlert.addTextField { (textfield:UITextField) in textfield.placeholder = "Author" }
            inputAlert.addTextField { (textfield:UITextField) in textfield.placeholder = "Year Published" }
            //save block in dialog
            inputAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action:UIAlertAction ) in
                let bookTextField = inputAlert.textFields?.first
                let authorTextField = inputAlert.textFields?[1]
                let yearTextField = inputAlert.textFields?.last
                //validation to ensure minumu length
                if bookTextField?.text != "" && authorTextField?.text != "" && yearTextField?.text != "" {
                    //preparing Books and year for save
                    BooksItem.title = inputAlert.textFields?.first?.text! as! String
                    BooksItem.author = inputAlert.textFields?[1].text! as! String
                    BooksItem.date = inputAlert.textFields?.last?.text! as! String
                    //save new record do/catch
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

