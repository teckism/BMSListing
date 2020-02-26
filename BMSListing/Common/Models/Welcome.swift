//
//  Welcome.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Welcome
class Welcome: Codable {
    let results: [Movie]?
    let page, totalResults: Int?
    let dates: Dates?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
    
    init(results: [Movie], page: Int, totalResults: Int, dates: Dates, totalPages: Int) {
        self.results = results
        self.page = page
        self.totalResults = totalResults
        self.dates = dates
        self.totalPages = totalPages
    }
    
    
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        dates = try values.decodeIfPresent(Dates.self, forKey: .dates)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        results = try values.decodeIfPresent([Movie].self, forKey: .results)
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ko = "ko"
}
