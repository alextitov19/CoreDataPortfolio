//
//  LanguageController.swift
//  CoreDataPortfolio
//
//  Created by Test on 4/21/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//

import UIKit
import CoreData

class LanguageController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var managedObjContext:NSManagedObjectContext! //context or delegate to managed entities
    var data = [Language]()     //where Program Language data is held
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Image/Title for Navigation
//       let backgroundImage = UIImage(named: "CDP_LanguageWallpaper.png")
//       let imageView = UIImageView(image: backgroundImage)
//       self.tableView.backgroundView = imageView
        let iconImageView = UIImageView(image: UIImage(named: "languages"))
        self.navigationItem.titleView = iconImageView
        //setup context or delegate for fetching, retrieving, storing data
        managedObjContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //populate Table View
        loadData()
    }
    
    func loadData() {
        
        //collect/fetch data from persistentent entity
        let dataRequest:NSFetchRequest<Language> = Language.fetchRequest()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LanguageTableViewCell
        
        //row or object in data source
        let row = data[indexPath.row]
        
        //load Table View from core data attributes
        if let picImage = UIImage(data: row.pic as Data) {
            cell.pic.image = picImage
        }
        cell.language.text = row.name
        cell.year.text = row.year 
        return cell
    }
    
    //Add Programming Language Action for add (+)
    @IBAction func addLanguage(_ sender: Any) {
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
    
    //Dialog and Data operations for adding a Programming Language
    func createProjLangItem (with image:UIImage) {
        let LanguageItem = Language(context: managedObjContext)
        
        //preparing image for save
        LanguageItem.pic = image.jpegData(compressionQuality: 0.3)!
        
        //inputAlert is dialog for new Programming Language entry
        let inputAlert = UIAlertController(title: "New Programming Language", message: "Enter Programming Language and Date", preferredStyle: .alert)
        inputAlert.addTextField { (textfield:UITextField) in textfield.placeholder = "Language" }
        inputAlert.addTextField { (textfield:UITextField) in textfield.placeholder = "Birth Year" }
        //save block in dialog
        inputAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action:UIAlertAction ) in
            let languageTextField = inputAlert.textFields?.first
            let yearTextField = inputAlert.textFields?.last
            //validation to ensure minumu length
            if languageTextField?.text != "" && yearTextField?.text != "" {
                //preparing language and year for save
                LanguageItem.name = inputAlert.textFields?.first?.text! as! String
                LanguageItem.year = inputAlert.textFields?.last?.text! as! String
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
