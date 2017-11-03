//
//  Comment.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-02.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import Foundation

struct Comment {
    fileprivate var _name: String!
    fileprivate var _comment: String!
    
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }

    var comment: String {
        get {
            return _comment
        }
        set {
            _comment = newValue
        }
    }
    
    init() {
        
    }
    
}
