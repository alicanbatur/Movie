//
//  Page.swift
//  Movie
//
//  Created by Ali Can Batur on 07/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation

/// Pagination operation's model object. Created as a class -not structure- because we need pass by referance abilities.
class Page {
    
    var index = 1
    
    /// Increases value of index to let us get other page items.
    func bumpUp() {
        index += 1
    }
    
    /// Resets index value to 1
    func reset() {
        index = 1
    }
    
}
