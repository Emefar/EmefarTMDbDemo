//
//  AppURL.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.


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


enum HTTPHeaderField: String {
    case authentication  = "Authorization"
    case contentType     = "Content-Type"
    case acceptType      = "Accept"
    case acceptEncoding  = "Accept-Encoding"
    case acceptLangauge  = "Accept-Language"
}

enum ContentType: String {
    case json            = "application/json"
    case multipart       = "multipart/form-data"
    case ENUS            = "en-us"
}

enum MultipartType: String {
    case image = "Image"
    case csv = "CSV"
}

enum MimeType: String {
    case image = "image/png"
    case csvText = "text/csv"
}

enum UploadType: String {
    case avatar
    case file
}


