//
//  MovieViewModel.swift
//  EmefarTMDbDemo
//
//  Created by Mervan Şahinkaya on 15.03.2022.
//  Copyright © 2022 Mervan Şahinkaya. All rights reserved.


import UIKit

protocol MovieViewModelProtocol {
    
    var movieDidChanges: ((Bool, Bool) -> Void)? { get set }
    
    
    func searchMovie(searchText: String, page: String)
}

class MovieViewModel: MovieViewModelProtocol {

    //MARK: - Internal Properties
    
    var movieDidChanges: ((Bool, Bool) -> Void)?
    
    var movies: [Movie] = [] {
        didSet {
            self.movieDidChanges!(true, false) // Send feedback evey movies data changed.
        }
    }
    

    func searchMovie(searchText: String, page: String) {
        
        if page == "1"{ // If first search, reset old data
            self.movies.removeAll()
        }

        MovieAPIService.instance.searchMovies(searchText: searchText, page: page) { result in
            switch result {
                
            case .success(let data):
                
                let mappedModel = try? JSONDecoder().decode(MovieResponseModel.self, from: data) as MovieResponseModel

                let newData = mappedModel?.movie ?? []
                
                if newData.count > 0 { // Check is data end. If end, cancel this method forever.
                    self.movies.append(contentsOf: newData)
                }
                
                
                
                break
            case .failure(let error):
                
                print(error.description)
            }
        }
    
    }
    
}
