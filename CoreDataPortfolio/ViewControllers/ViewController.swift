//
//  ViewController.swift
//  CoreDataPortfolio
//
//  Created by Test on 4/20/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func LoginLabButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginController") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func languagesButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Language", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LanguageController") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @IBAction func booksButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Book", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookController") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}

