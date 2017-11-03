//
//  PostsViewController.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-01.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    fileprivate var model = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    fileprivate func additionalSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func getData() {
        PostManager.shared.getPosts { (success, error, data) in
            if error != nil || !success {
                self.show(error: "Vi hittade inga inlägg, försök igen om en stund.")
                return
            }
            guard let posts = data as? [Post] else {
                self.show(error: "Vi hittade inga inlägg, försök igen om en stund.")
                return
            }
            self.model = posts
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCommentsSegue" {
            if let destination = segue.destination as? CommentsViewController,
                let postIdString = sender as? String {
                destination.currentPostId = postIdString
            }
        }
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as! PostsTableViewCell
        cell.config(post: model[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedKey = model[indexPath.row].postId
        performSegue(withIdentifier: "ShowCommentsSegue", sender: selectedKey)
    }
}


















