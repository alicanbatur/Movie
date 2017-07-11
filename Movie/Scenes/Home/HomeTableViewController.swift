//
//  HomeTableViewController.swift
//  Movie
//
//  Created by Ali Can Batur on 06/07/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let homePresenter = HomePresenter(interactor: HomeInteractor())
    fileprivate var movies = [Movie]()
    fileprivate var queries = [String]()
    
    var searchController: UISearchController!
    var isSearching = false
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        refreshControl?.addTarget(self, action: #selector(HomeTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        configureSearchController()
        
        homePresenter.attachView(view: self)
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        homePresenter.refreshItems()
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = Constants.Placeholder.searchBar

        tableView.tableHeaderView = searchController.searchBar
    }
    
    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return queries.count
        } else {
            return movies.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearching {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.CellName.basicCell, for: indexPath)
            cell.textLabel?.text = queries[indexPath.row]
            return cell
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellReuseIdentifier(), for: indexPath) as! MovieTableViewCell
            let movie = movies[indexPath.row]
            cell.populateCell(movie: movie)
            return cell
        }
    }
   
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !isSearching { return }
        homePresenter.searchQuery(query: queries[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isSearching { return }
        
        if indexPath.row == movies.count - 3 {
            homePresenter.paginateSearchQuery()
        }
    }
    
}

extension HomeTableViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        homePresenter.fetchQueries()
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = searchText.characters.count > 0
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        homePresenter.searchQuery(query: searchBar.text!)
    }
    
}

extension HomeTableViewController: HomeView {
 
    func startLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func finishLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        refreshControl?.endRefreshing()
    }
    
    func setMovies(movies: [Movie], shouldReset: Bool) {
        if shouldReset {
            self.movies = movies
        } else {
            self.movies.append(contentsOf: movies)
        }
        
        dismissSearchControllerIfExists()
        // Omg, kidding me!
        self.tableView.reloadData()
    }
    
    func setPositiveQueries(queries: [String]) {
        self.queries = queries
    }
    
    func showAlert(title: String, description: String) {
        let controller = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
        controller.addAction(action)
        navigationController?.present(controller, animated: true, completion: nil)
    }
    
    func dismissSearchControllerIfExists() {
        if isSearching {
            isSearching = false
            self.searchController.searchBar.resignFirstResponder()
            searchController.dismiss(animated: true, completion: nil)
            self.searchController.searchBar.text = ""
            self.tableView.reloadData()
        }
    }
    
}
