//
//  HomePresenter.swift
//  Movie
//
//  Created by Ali Can Batur on 06/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation

class HomePresenter {
    
    let interactor: HomeInteractor
    weak private var homeView: HomeView?
    
    var page = Page()
    var isPaginating = false
    var currentQuery = "" {
        didSet {
            interactor.storeQuery(query: currentQuery)
        }
    }
    
    // MARK: - Initialization & Configuration
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
    }
    
    func attachView(view: HomeView?) {
        guard let view = view else { return }
        homeView = view
    }
    
    // MARK: - Search Methods
    
    func searchQuery(query: String) {
        let shouldReset = (query != self.currentQuery)
        if shouldReset {
            isPaginating = false
            page.reset()
        }
        search(with: query, page: page, shouldReset: shouldReset)
    }
    
    func paginateSearchQuery() {
        isPaginating = true
        page.bumpUp()
        searchQuery(query: currentQuery)
    }
    
    /// TableView's refresh event.
    func refreshItems() {
        isPaginating = false
        page.reset()
        search(with: currentQuery, page: page, shouldReset: true)
    }
    
    // MARK: - Query store & fetch operations
    
    /// Fetch already stored queries
    func fetchQueries() {
        self.homeView?.setPositiveQueries(queries: interactor.fetchQueries())
    }
    
    func storeQuery(query: String) {
        interactor.storeQuery(query: query)
    }
    
    // MARK: - Interactor Access
    
    func search(with query: String, page: Page, shouldReset: Bool) {
        self.homeView?.startLoading()
        
        interactor.search(query: query, page: page, result: { [weak self] movies in
            
            guard let `self` = self else { return }
            self.homeView?.finishLoading()
            
            guard movies.count != 0 else {
                self.homeView?.showAlert(title: "No result found", description: "")
                return
            }
            
            self.homeView?.setMovies(movies: movies, shouldReset: shouldReset)
            
            self.currentQuery = query
        }) { [weak self] (error) in
            
            guard let `self` = self else { return }
            
            if self.isPaginating && (error.code == 100) { return }
            
            self.homeView?.finishLoading()
            self.homeView?.dismissSearchControllerIfExists()
            self.homeView?.showAlert(title: error.title, description: error.description)
        }
    }

}
