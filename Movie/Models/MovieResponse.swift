//
//  MoviewResponse.swift
//  Movie
//
//  Created by Ali Can Batur on 07/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import ObjectMapper

/// Direct response object of the request. This response object created to handle movies json array from response json.
struct MovieResponse: Mappable {
    
    var movies: [Movie]?    // results
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        movies  <-  map["results"]
    }
    
}

