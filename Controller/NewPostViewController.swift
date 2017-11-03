//
//  NewPostViewController.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-01.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    fileprivate func additionalSetup() {
        createButton.layer.cornerRadius = 4.0
    }
    
    @IBAction func createPost(_ sender: UIButton) {
        guard let text = textView.text, !text.isEmpty else {
            show(error: "Du kan inte skapa ett inlägg just nu, försök igen om en stund.")
            return
        }
        PostManager.shared.createPost(withText: text) { (success, error, _) in
            if error != nil || !success {
                self.show(error: "Du kan inte skapa ett inlägg just nu, försök igen om en stund")
                return
            }
            self.performSegue(withIdentifier: "ShowAllPostsSegue", sender: nil)
        }
    }
}
