//
//  HomeViewController.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-01.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    fileprivate var appDel = (UIApplication.shared.delegate as! AppDelegate)
    override func viewDidLoad() {
        super.viewDidLoad()
        additonalSetup()
    }
    
    fileprivate func additonalSetup() {
        nextButton.layer.cornerRadius = 4.0
    }
    
    @IBAction func next(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            show(error: "Skriv ditt namn innan du forstätter.")
            return
        }
        LoginManager.shared.authenticateUser(withName: name) { (success, error, data) in
            if error != nil || !success {
                self.show(error: "Du kan inte skapa ett konto just nu, försök igen om en stund")
                return
            }
            print("Seguing..")
            self.performSegue(withIdentifier: "LoggedInNewPostSegue", sender: name)
            self.appDel.username = name
        }
    }
}
