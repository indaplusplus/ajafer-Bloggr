//
//  PostsTableViewCell.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-02.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func config(post: Post) {
        nameLabel.text = "\(post.name) skriver:"
        descriptionLabel.text = post.text
    }
    
    func config(comment: Comment) {
        nameLabel.text = "- \(comment.name)"
        descriptionLabel.text = "\"\(comment.comment)\""
    }
    
}
