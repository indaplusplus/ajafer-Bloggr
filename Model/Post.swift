//
//  Post.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-02.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation

struct Post {
    fileprivate var _postId: String!
    fileprivate var _author: String!
    fileprivate var _name: String!
    fileprivate var _text: String!
    
    var postId: String {
        get {
            return _postId
        }
        set {
            _postId = newValue
        }
    }
    
    var author: String {
        get {
            return _author
        }
        set {
            _author = newValue
        }
    }
    
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    var text: String {
        get {
            return _text
        }
        set {
            _text = newValue
        }
    }
    
    init() {
        
    }
}
