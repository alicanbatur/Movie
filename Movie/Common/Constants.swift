//
//  Constants.swift
//  Movie
//
//  Created by Ali Can Batur on 07/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

/// All constant values are stored here.

struct Constants {
    
    /// API constants
    struct API {
        static let key = "2696829a81b1b5827d515ff121700838"
    }
    
    /// Url constants
    struct Url {
        static let baseURLString = "http://api.themoviedb.org/3"
        static let posterBaseUrl = "http://image.tmdb.org/t/p/w185"
    }
    
    /// UImage constants
    struct Image {
        static let noPhoto = UIImage(named: "noPhoto")!
    }
    
    /// UITableViewCell identifier constants which are not custom class
    struct CellName {
        static let basicCell = "BasicCell"
    }
    
    /// UserDefaults key constants
    struct UserDefaultsKey {
        static let queries = "queryList"
    }
    
    /// Placeholder texts
    struct Placeholder {
        static let searchBar = "Type to search a movie"
    }
    
}
