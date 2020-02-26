
//
//  MovieCredits.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class MovieCredits: Codable {
    
    let id: Int?
    let cast: [Cast]?
    
    
    enum CodingKeys: String, CodingKey {
        case id, cast
        
    }
    
    init(id: Int, cast: [Cast]) {
        self.id = id
        self.cast = cast
    }
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        cast = try values.decodeIfPresent([Cast].self, forKey: .cast)
    }
}
