//
//  Cast.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class Cast: Codable {
    
    let id: Int?
    let castID: Int?
    let gender: Int?
    let order: Int?
    
    let character: String?
    let profilePath: String?
    let name: String?
    let creditID: String?
    
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case castID = "cast_id"
        case character, gender, name, order
        case creditID = "credit_id"
        
        case profilePath = "profile_path"
        
    }
    
    init(id: Int,castID: Int,gender: Int,order: Int, character: String, profilePath: String, name: String, creditID: String) {
        self.id = id
        self.castID = castID
        self.gender = gender
        self.order = order
        self.character = character
        self.profilePath = profilePath
        self.name = name
        self.creditID = creditID
    }
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        castID = try values.decodeIfPresent(Int.self, forKey: .castID)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        character = try values.decodeIfPresent(String.self, forKey: .character)
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        creditID = try values.decodeIfPresent(String.self, forKey: .creditID)
    }
    
}
