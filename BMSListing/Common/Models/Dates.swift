//
//  Dates.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit
import Foundation

class Dates: Codable {
    let maximum, minimum: String?
    
    enum CodingKeys: String, CodingKey {
           case maximum, minimum
        
       }

    init(maximum: String, minimum: String) {
        self.maximum = maximum
        self.minimum = minimum
    }
    required init(from decoder:Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           maximum = try values.decodeIfPresent(String.self, forKey: .maximum)
           minimum = try values.decodeIfPresent(String.self, forKey: .minimum)
    }
}
