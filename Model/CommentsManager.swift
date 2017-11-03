//
//  CommentsManager.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-02.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation
import Firebase

struct CommentsManager {
    fileprivate static var _shared = CommentsManager()
    static var shared: CommentsManager {
        return _shared
    }
    
    fileprivate var root: DatabaseReference!
    fileprivate var commentRef: DatabaseReference!
    
    private init () {
        root = Database.database().reference()
        commentRef = root.child("PostComments")
    }
    
    func createComment(comment: String, forPost postId: String, completion: @escaping completed) {
        guard let username = (UIApplication.shared.delegate as! AppDelegate).username else {
            print("CommentsManager: Failed to create comment, no valid username found.")
            completion(false, nil, nil)
            return
        }
        let commentKey = commentRef.child(postId).childByAutoId().key
        let values = [
            "Name": username,
            "Comment": comment
        ]
        commentRef.child(postId).child(commentKey).updateChildValues(values) { (error, _) in
            if error != nil {
                print("CommentsManager: Failed to create comment with error: \(error?.localizedDescription)")
                return
            }
            print("CommentsManager: Successfully created comment.")
            completion(true, nil, nil)
        }
    }
    
    func getComments(forPost postId: String, completion: @escaping completed) {
        commentRef.child(postId).observeSingleEvent(of: .value) { (snapshot) in
            if let dataDict = snapshot.value as? NSDictionary {
                var comments = [Comment]()
                for (_, value) in dataDict {
                    if let commentDict = value as? NSDictionary {
                        var comment = Comment()
                        if let name = commentDict["Name"] as? String {
                            comment.name = name
                        }
                        if let commentString = commentDict["Comment"] as? String {
                            comment.comment = commentString
                        }
                        comments.append(comment)
                    }
                }
                print("CommentsManager: Successly got comments.")
                completion(true, nil, comments)
            } else {
                print("CommentsManager: Failed to get comments, no data found")
                completion(false, nil, nil)
            }
        }
    }
    
}
