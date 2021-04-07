//
//  MovieAPIService.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.


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

extension String {
    func URLEncoded() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
