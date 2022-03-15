//
//  AppURL.swift
//  EmefarTMDbDemo
//
//  Created by Mervan Şahinkaya on 15.03.2022.
//  Copyright © 2022 Mervan Şahinkaya. All rights reserved.


import UIKit

struct Domain {
    static let dev = "http://api.themoviedb.org/"
    static let assest = "http://image.tmdb.org/t/p/"

}
extension Domain {
    static func baseUrl() -> String {
        return Domain.dev
    }
}

struct APIEndpoint {
    static let movies = "3/discover/movie?api_key=57a4269b6c0098d52f01d65572e57972&sort_by=popularity.desc"
    static let search = "3/search/movie?api_key=57a4269b6c0098d52f01d65572e57972&query="
}
