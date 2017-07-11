//
//  HomeView.swift
//  Movie
//
//  Created by Ali Can Batur on 06/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation

protocol HomeView: class {
    
    func startLoading()
    func finishLoading()
    func setMovies(movies: [Movie], shouldReset: Bool)
    func setPositiveQueries(queries: [String])
    func showAlert(title: String, description: String)
    func dismissSearchControllerIfExists()
    
}
