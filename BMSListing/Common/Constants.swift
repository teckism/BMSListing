//
//  Constants.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//


import UIKit

public struct Constants {
    static let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    struct ApiKeys {
        static let kApiKey = "1bf10d58df2b1d317dcde15d78e8b76c"
    }
    struct Alerts {
        static let kUnableToReachServer = "Unable to reach server"
        static let TRY_AGAIN = "Try Again"
        static let ERROR_KEY = "Error"
        static let OK = "Ok"
        
    }
    struct BaseUrls {
        static let kAPIBaseUrl = "https://api.themoviedb.org/3/"
        static let kPosterBaseUrl = "https://image.tmdb.org/t/p/w185_and_h278_bestv2"
        static let kProfilePathBaseUrl = "https://image.tmdb.org/t/p/w138_and_h175_face"
    }
    
    struct WebServices {
        static let kGetMovieListing = "movie/now_playing"
        static let kGetGenres = "genre/movie/list"
        static let kGetMovieDetails = "movie/"
        static let kMovieCredits = "movie/{movie_id}/credits"
        static let kSimilarMovies = "movie/{movie_id}/similar"
    }
    struct CellIdentifiers {
        static let kMovieListingCellIdentifier = "movieListingCell"
        static let kMovieDetailsCellIdentifier = "movieDetailsCell"
        static let kMovieCreditsCellIdentifier = "movieCreditsUICell"
        static let kMovieCastCellIdentifier = "movieCastCell"
        
        static let kSimilarMoviesListingCellIdentifier = "movieSimilarListingCell"
        static let kSimilarMovieCellIdentifier = "similarMovieCell"
        
    }
    struct Cells {
        static let kMovieListingCell = "MovieListingItemTableViewCell"
        static let kMovieCreditsCell = "MovieCreditsUITableViewCell"
        static let kMovieCastCell = "MovieCastCollectionViewCell"
        static let kSimilarMoviesListingCell = "MovieSimilarListingTableViewCell"
        static let kSimilarMovieCell = "SimilarMovieCollectionViewCell"
    }
    
    struct Images {
        static let kImageForBackNavigation = UIImage.init(named: "icon_back")!
    }
    
    struct StoryBoardIdentifiers {
        static let kMovieDetailsViewControllerIdenfier = "movieDetailsVC"
    }
}
