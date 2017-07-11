//
//  HomeInteractor.swift
//  Movie
//
//  Created by Ali Can Batur on 06/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation

class HomeInteractor {
    
    // MARK: - Search Call
    
    func search(query: String,
                page: Page,
                result: @escaping (([Movie]) -> Void),
                failure: @escaping (errorHandler) = { _ in }) {
        Networking.searchMovies(with: query, page: page, success: { movies in
            result(movies)
        }) { error in
            failure(error)
        }
    }
    
    // MARK: - Storing & fetching query data from UserDefaults
    
    func fetchQueries() -> [String] {
        let userDefaults = UserDefaults.standard
        guard let queries = userDefaults.array(forKey: Constants.UserDefaultsKey.queries) as? [String] else {
            return []
        }
        return queries
    }
    
    func resetStoredQueries() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey:Constants.UserDefaultsKey.queries)
        userDefaults.synchronize()
    }
    
    func storeQuery(query: String) {
        var queries = self.fetchQueries()
    
        if queries.contains(query) {
            queries.remove(at: queries.index(of: query)!)
            queries.insert(query, at: 0)
        } else {
            
            if queries.count == 10 {
                queries.removeLast()
            }
            
            queries.insert(query, at: 0)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(queries, forKey:Constants.UserDefaultsKey.queries)
        userDefaults.synchronize()
    }
    
}
