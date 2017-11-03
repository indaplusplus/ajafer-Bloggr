//
//  CommentsViewController.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-02.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    fileprivate var model = [Comment]()
    
    var currentPostId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    @IBAction func comment(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ShowCommentViewSegue", sender: nil)
    }
    
    fileprivate func additionalSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func getData() {
        guard let postId = currentPostId else {
            show(error: "Vi hittar inga kommentarer just nu, försök igen om en stund")
            return
        }
        CommentsManager.shared.getComments(forPost: postId) { (success, error, data) in
            if error != nil || !success {
                self.show(error: "Vi hittar inga kommentarer just nu, försök igen om en stund")
                return
            }
            guard let comments = data as? [Comment] else {
                self.show(error: "Vi hittar inga kommentarer just nu, försök igen om en stund")
                return
            }
            self.model = comments
            print("Found: \(self.model.count) comments.")
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCommentViewSegue" {
            if let destination = segue.destination as? NewCommentViewController,
                let postId = currentPostId {
                destination.currentPostId = postId
            }
        }
    }
    
}

extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as! PostsTableViewCell
        cell.config(comment: model[indexPath.row])
        return cell
    }
}
