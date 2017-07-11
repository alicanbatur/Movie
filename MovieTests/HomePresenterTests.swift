//
//  HomePresenterTests.swift
//  Movie
//
//  Created by Ali Can Batur on 07/07/2017.
//  Copyright © 2017. All rights reserved.
//

import XCTest
@testable import Movie

class HomePresenterTests: XCTestCase {
    
    var home: HomeTableViewController!
    var navigation: UINavigationController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        navigation = storyboard.instantiateInitialViewController() as! UINavigationController
        home = navigation.viewControllers.first as! HomeTableViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBatmanSearch() {
        testSearch(query: "Batman", result: { movies in
            XCTAssertTrue((movies.first?.title?.lowercased().contains("batman"))!, "First item should contain 'batman' word!")
        })
    }
    
    func testMeaninglessSearch() {
        testSearch(query: "qweqweqweqweqw", result: { movies in
            XCTAssertFalse((movies.first?.title?.contains("qweqweqweqweqw"))!, "This word should be meaningless.")
        }) { error in
            XCTAssertTrue(error.code == 100, "Error is not what we are looking for.")
        }
    }
    
    func testStoreAndFetchQueries() {
        let queryToTest = "Batman"
        home.homePresenter.storeQuery(query: queryToTest)
        let queries = fetchQueries()
        
        XCTAssertTrue(queries.contains(queryToTest))
    }
    
    func testStoringQueryIsLimitedToTen() {
        home.homePresenter.interactor.resetStoredQueries()
        let queries = ["Batman", "Superman", "Matrix", "Harry Potter", "Taken", "Mummy", "Arrival", "The Day", "Alone", "Trolls"]
        for query in queries {
            home.homePresenter.storeQuery(query: query)
        }
        // added 10 items up to here.
        home.homePresenter.storeQuery(query: "Steve")
        XCTAssertTrue(fetchQueries().count == 10, "Stored queries should be limited to 10! It's \(fetchQueries().count)")
    }
    
    func fetchQueries() -> [String] {
        return home.homePresenter.interactor.fetchQueries()
    }
    
    func testSearch(query: String,
                    result: @escaping (([Movie]) -> Void),
                    failure: @escaping (errorHandler) = { _ in }) {
        let expect = expectation(description: "Array should make a search using: \(query)")
        
        home.homePresenter.interactor.search(query: query, page: Page(), result: { (movies) in
            
            // Check existing items
            XCTAssertNotNil(movies, "Movies array should not be nil!")
            XCTAssertTrue(movies.count > 0, "Movies array should not be empty!")
            
            result(movies)
            
            expect.fulfill()
        }) { error in
            failure(error)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "Test timed out. \(error?.localizedDescription ?? "error occured")")
        }
    }
}


