//
//  PostManager.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-02.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation
import Firebase

struct PostManager {
    fileprivate static var _shared = PostManager()
    static var shared: PostManager {
        return _shared
    }
    
    fileprivate var root: DatabaseReference!
    fileprivate var postRef: DatabaseReference!
    fileprivate var userPostRef: DatabaseReference!
    
    fileprivate let appDel = (UIApplication.shared.delegate as! AppDelegate)
    
    private init() {
        root = Database.database().reference()
        postRef = root.child("Posts")
        userPostRef = root.child("UserPosts")
    }
    
    func getPosts(completion: @escaping completed) {
        postRef.observeSingleEvent(of: .value) { (snapshot) in
            if let dataDict = snapshot.value as? NSDictionary {
                var posts = [Post]()
                for (key,value) in dataDict {
                    if let postDict = value as? NSDictionary, let stringKey = key as? String {
                        var post = Post()
                        post.postId = stringKey
                        if let author = postDict["Author"] as? String {
                            post.author = author
                        }
                        if let name = postDict["Name"] as? String {
                            post.name = name
                        }
                        if let text = postDict["Text"] as? String {
                            post.text = text
                        }
                        posts.append(post)
                    }
                }
                completion(true, nil, posts)
            }
        }
    }
    
    func createPost(withText text: String, completion: @escaping completed) {
        guard let userId = Auth.auth().currentUser?.uid, let name = appDel.username else {
            print("PostManager: Failed to create post, no valid userid found")
            completion(false, nil, nil)
            return
        }
        let postKey = postRef.childByAutoId().key
        let values = [
            "Author" : userId,
            "Name"   : name,
            "Text"   : text
        ] as [AnyHashable : Any]
        postRef.child(postKey).updateChildValues(values) { (error, _) in
            if error != nil {
                print("PostManager: Failed to save post with error: \(String(describing: error?.localizedDescription))")
                completion(false,error,nil)
                return
            }
            self.userPostRef.child(userId).child(postKey).setValue(true)
            print("PostManager: Successfully saved post.")
            completion(true,nil,nil)
        }
    }
    
}
