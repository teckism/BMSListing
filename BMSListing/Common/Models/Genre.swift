//
//  Genre.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class Genre: Codable {
    
    let id : Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
