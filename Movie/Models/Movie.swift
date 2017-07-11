//
//  Movie.swift
//  Movie
//
//  Created by Ali Can Batur on 06/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import ObjectMapper

/// Movie model object. ObjectMapper lets us to map object with json data comes from http call.
/// Here we also can imageURL directly
struct Movie: Mappable {
    
    var identifier: Int?        // id
    var title: String?          // title
    var overview: String?       // overview
    var releaseDate: String?    // release_date
    var posterPath: String?     // poster_path
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        identifier  <-  map["id"]
        title       <-  map["title"]
        overview    <-  map["overview"]
        releaseDate <-  map["release_date"]
        posterPath  <-  map["poster_path"]
    }
    
    // MARK: - Public Funcs
    
    /// Builds and returns movie object's imageURL if exists.
    ///
    /// - Returns: URL
    func imageURL() -> URL? {
        var urlString = Constants.Url.posterBaseUrl
        guard let posterPath = self.posterPath else { return nil }
        urlString.append(posterPath)
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
    
}
