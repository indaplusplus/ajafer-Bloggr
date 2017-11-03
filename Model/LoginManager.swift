//
//  File.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-01.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation
import Firebase

struct LoginManager {
    fileprivate static var _shared = LoginManager()
    static var shared: LoginManager {
        return _shared
    }
    
    fileprivate var root: DatabaseReference!
    fileprivate var userRef: DatabaseReference!
    
    private init(){
        root = Database.database().reference()
        userRef = root.child("Users")
    }
    
    func authenticateUser(withName name: String, completion: @escaping completed) {
        Auth.auth().signInAnonymously { (user, error) in
            if error != nil {
                print("LoginManager: Failed to authenticate anonymously with error: \(String(describing: error?.localizedDescription))")
                completion(false, error, nil)
                return
            }
            guard let user = user else {
                print("LoginManager: Failed to login, no valid user found.")
                completion(false, nil, nil)
                return
            }
            self.save(userId: user.uid, name: name)
            completion(true,nil,nil)
        }
    }
    
    fileprivate func save(userId: String, name: String) {
        userRef.child(userId).updateChildValues(["Name" : name])
    }
    
}
