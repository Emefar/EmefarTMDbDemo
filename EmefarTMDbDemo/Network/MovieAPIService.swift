//
//  MovieAPIService.swift
//  EmefarTMDbDemo
//
//  Created by Mervan Şahinkaya on 15.03.2022.
//  Copyright © 2022 Mervan Şahinkaya. All rights reserved.


import UIKit

class MovieAPIService: NSObject, Requestable {

    static let instance = MovieAPIService()
    
    public var movies: [Movie]?

    
    func fetchMovies(callback: @escaping Handler) { // For sample
        
        request(method: .get, url: Domain.baseUrl() + APIEndpoint.movies) { (result) in
            
           callback(result)
        }
        
    }
    
    func searchMovies(searchText: String, page: String, callback: @escaping Handler) {
        
        request(method: .get, url: Domain.baseUrl() + APIEndpoint.search + searchText.URLEncoded() + "&page=" + page) { (result) in
            
           callback(result)
        }
        
    }
    
}
