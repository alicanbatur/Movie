//
//  TMDBRequestBuilder.swift
//  Movie
//
//  Created by Ali Can Batur on 06/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import Alamofire

/// Build request based on the selected enum.
enum TMDBRequestBuilder: URLRequestConvertible {
    
    case searchMovie(String, Page)
    
    /// URLRequestConvertible's method.
    func asURLRequest() throws -> URLRequest {
        
        /// Set case's http method.
        var method: HTTPMethod {
            switch self {
            case .searchMovie(_,_):
                return .get
            }
        }
        
        /// Create URL based on the enum of request.
        let url:URL = {
            let relativePath: String?
            
            switch self {
            case .searchMovie(let query, let page):
                let encodedQuery = query.encode()
                relativePath = "/search/movie?api_key=\(Constants.API.key)&query=\(encodedQuery)&page=\(page.index)"
            }
            
            var urlString = Constants.Url.baseURLString
            if let relativePath = relativePath {
                urlString.append(relativePath)
            }
            return URL(string: urlString)!
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest)
    }
    
}
