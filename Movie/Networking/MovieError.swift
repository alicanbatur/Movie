//
//  MovieError.swift
//  Movie
//
//  Created by Ali Can Batur on 07/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation

/// Custom error to handle as we want.
protocol MovieErrorProtocol: Error {
    
    var title: String { get }
    var description: String { get }
    var code: Int { get }

}

struct MovieError: MovieErrorProtocol {
    
    var title: String
    var description: String
    var code: Int
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self.description = description
        self.code = code
    }

}
