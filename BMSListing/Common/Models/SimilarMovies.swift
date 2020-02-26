//
//  SimilarMovies.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class SimilarMovies: Codable {
    let results: [Movie]?
    let page, totalResults: Int?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
       
        case totalPages = "total_pages"
    }
    
    init(results: [Movie], page: Int, totalResults: Int, totalPages: Int) {
        self.results = results
        self.page = page
        self.totalResults = totalResults
        
        self.totalPages = totalPages
    }
  
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        results = try values.decodeIfPresent([Movie].self, forKey: .results)
    }

}
