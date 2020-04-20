//
//  LoginController.swift
//  CoreDataPortfolio
//
//  Created by Test on 4/20/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    
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
    
    func addAccount() {
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
                   return
               }
        let account = Account(entity: Account.entity(), insertInto: context)
        account.username = username
        account.password = password
        accounts.append(account)
        appDelegate.index = accounts.count - 1
        appDelegate.saveContext()
        showAccountVC()
    }
    
    func loginAccount() {
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        for i in 0..<accounts.count {
            if(accounts[i].username == username && accounts[i].password == password) {
                NSLog("Login successful, \(i)")
                appDelegate.index = i
                showAccountVC()
            }
        }
    }
    

    
    func showAccountVC() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "AccountController") as UIViewController
               vc.modalPresentationStyle = .fullScreen
               present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
         NSLog(String(accounts.count))
        loginAccount()
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        addAccount()
    }
}
