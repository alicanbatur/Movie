//
//  Networking.swift
//  Movie
//
//  Created by Ali Can Batur on 06/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

typealias errorHandler = (_ error: MovieError) -> ()

/// Networking class is a proxy between our architecture and http calls. Here Alamofire is choosen to complete calls, but in any case of change request for alamofire can be handled here easily.
class Networking {
    
    /// Requests movies using a query param
    /// 
    /// - parameter query: query to be requested
    /// - parameter page: lets us handle pagination
    /// - parameter success: closure to handle succeed case
    /// - parameter failure: closure to handle failure case
    /// - Returns: Nothing. Callbacks does what to be done after async call.
    class func searchMovies(with query: String,
                            page: Page,
                            success: @escaping ((_ result: [Movie]) -> ()),
                            failure: @escaping (errorHandler) = { _ in }) {
        Alamofire.request(TMDBRequestBuilder.searchMovie(query, page)).responseObject { (response: DataResponse<MovieResponse>) in
            
            if let error = response.error {
                failure(MovieError(title: error.localizedDescription, description: "", code: error._code))
                return
            }
            
            guard let movies = response.result.value?.movies else {
                return
            }
            
            guard movies.count > 0 else {
                failure(MovieError(title: "This query has no data", description: "", code: 100))
                return
            }
            
            success(movies)
        }
    }
    
}
