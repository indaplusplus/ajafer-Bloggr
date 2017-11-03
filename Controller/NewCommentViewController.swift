//
//  NewCommentViewController.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-02.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import UIKit

class NewCommentViewController: UIViewController {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var newCommentButton: UIButton!
    
    var currentPostId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalSetup()
    }
    
    @IBAction func addComment(_ sender: UIButton) {
        guard let text = commentTextView.text, let postId = currentPostId, !text.isEmpty else {
            show(error: "Skriv gärna en kommentar innan du fortsätter")
            return
        }
        CommentsManager.shared.createComment(comment: text, forPost: postId) { (success, error, data) in
            if error != nil || !success {
                self.show(error: "Du kan inte kommentera just nu, försök igen om en stund.")
                return
            }
            let alertController = UIAlertController(title: "Klar!", message: "Din kommentar för detta inlägg har sparats", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Avbryt", style: .cancel, handler: { (_) in
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(cancelButton)
            self.present(alertController, animated: true)
        }
    }
    
    fileprivate func additionalSetup() {
        commentTextView.layer.cornerRadius = 4.0
        newCommentButton.layer.cornerRadius = 4.0
    }

}
