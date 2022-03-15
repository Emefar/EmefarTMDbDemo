//
//  Movie.swift
//  EmefarTMDbDemo
//
//  Created by Mervan Şahinkaya on 15.03.2022.
//  Copyright © 2022 Mervan Şahinkaya. All rights reserved.
//

import UIKit
import Foundation

struct MovieResponseModel : Codable {
   // let page : Int?
   // let total_results : Int?
   // let total_pages : Int?
    let movie : [Movie]?
    
    enum CodingKeys: String, CodingKey {
        
        //   case page = "page"
        //   case total_results = "total_results"
        //   case total_pages = "total_pages"
        case movie = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
      //  page = try values.decodeIfPresent(Int.self, forKey: .page)
      //  total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
      //  total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        movie = try values.decodeIfPresent([Movie].self, forKey: .movie)
    }
    
}

struct Movie : Codable {
    
    let id : Int?
    let vote_average : Double?
    let title : String?
    let poster_path : String?
    let overview : String?
    let release_date : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case vote_average = "vote_average"
        case title = "title"
        case poster_path = "poster_path"
        case overview = "overview"
        case release_date = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
    }
    
}
