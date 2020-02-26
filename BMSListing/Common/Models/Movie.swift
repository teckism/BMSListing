//
//  Result.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit
import Foundation

class Movie: Codable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let originalLanguage: OriginalLanguage?
    let originalTitle: String?
    let genreIDS: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id
        case adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    init(popularity: Double, voteCount: Int, video: Bool, posterPath: String, id: Int, adult: Bool, backdropPath: String, originalLanguage: OriginalLanguage, originalTitle: String, genreIDS: [Int], title: String, voteAverage: Double, overview: String, releaseDate: String) {
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.posterPath = posterPath
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        originalLanguage = try values.decodeIfPresent(OriginalLanguage.self, forKey: .originalLanguage)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        genreIDS = try values.decodeIfPresent([Int].self, forKey: .genreIDS)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        
    }
    
    
}
