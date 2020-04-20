//
//  AccountController.swift
//  CoreDataPortfolio
//
//  Created by Test on 4/20/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//

import UIKit

class AccountController: UIViewController {
    
    @IBOutlet var currentPasswordTextField: UITextField!
    @IBOutlet var newPasswordTextField: UITextField!
    @IBOutlet var retypePasswordTextField: UITextField!
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var accounts = [Account]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            accounts = try context.fetch(Account.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func changePassword() {
        if(accounts[appDelegate.index!].password == currentPasswordTextField.text!) {
            if(newPasswordTextField.text! == retypePasswordTextField.text!) {
                NSLog("Password changed")
                accounts[appDelegate.index!].password = newPasswordTextField.text!
                appDelegate.saveContext()
            }
        }
    }
    
    func showLoginVC() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginController") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func deleteAccount() {
        NSLog("Account deleted")
        NSLog(String(accounts.count))
        context.delete(accounts[appDelegate.index!])
        accounts.remove(at: appDelegate.index!)
        appDelegate.saveContext()
        NSLog(String(accounts.count))
        do {
            accounts = try context.fetch(Account.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        NSLog(String(accounts.count))
        
    }
    
    @IBAction func changePasswordButtonPresed(_ sender: UIButton) {
        changePassword()
        showLoginVC()
    }
    
    @IBAction func deleteAccountButtonPressed(_ sender: UIButton) {
        deleteAccount()
        showLoginVC()
    }
    
}
