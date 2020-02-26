//
//  MovieDetailsDataController.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

enum ListingTypes {
    case details
    case castAndCrew
    case similarMovies
}

import UIKit

class MovieDetailsDataController: NSObject {
    
    var movie : Movie?
    var movieDetails : MovieDetails?
    var arrayOfAllGenres : [Genre]?
    
    var credits : MovieCredits?
    var similarMovies : SimilarMovies?
    
    func getMovieDetails(onSuccess:@escaping ()->Void , onFailure:@escaping (_ result: String)->Void)
    {
        
        APIManager.sharedInstance.httpGETCall(apiFor: .movieDetails(movieId: (movie?.id!)!), params: [:], success: { (responseFromServer) in
            
            
            if let dataFromServer = responseFromServer as? Data {
                do {
                    // 1
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    // 2
                    self.movieDetails = try decoder.decode(MovieDetails.self, from: dataFromServer)
                   
                    onSuccess();
                } catch let error {
                    // 3
                    print("Error creating obj from JSON because: \(error.localizedDescription)")
                    onFailure("");
                }
            }
            else{
                
                onFailure("");
            }
            
        }) { (error) in
            //Error Handling
            onFailure("");
        }
    }
    
    
    func getMovieCredits(onSuccess:@escaping ()->Void , onFailure:@escaping (_ result: String)->Void)
    {
        
        APIManager.sharedInstance.httpGETCall(apiFor: .movieCredits(movieId: (movie?.id!)!), params: [:], success: { (responseFromServer) in
            
            
            if let dataFromServer = responseFromServer as? Data {
                do {
                    // 1
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    // 2
                    self.credits = try decoder.decode(MovieCredits.self, from: dataFromServer)
                   
                    onSuccess();
                } catch let error { // 3
                    print("Error creating obj from JSON because: \(error.localizedDescription)")
                    onFailure("");
                }
            }
            else{
                
                onFailure("");
            }
            
        }) { (error) in
            //Error Handling
            onFailure("");
        }
        
        
    }
    
    
    func getSimilarMovies(onSuccess:@escaping ()->Void , onFailure:@escaping (_ result: String)->Void)
       {
           
        APIManager.sharedInstance.httpGETCall(apiFor: .similarMovies(movieId: (self.movie?.id!)!), params: [:], success: { (responseFromServer) in
               
               
               if let dataFromServer = responseFromServer as? Data {
                   do {
                       // 1
                       let decoder = JSONDecoder()
                       decoder.keyDecodingStrategy = .useDefaultKeys
                       // 2
                       self.similarMovies = try decoder.decode(SimilarMovies.self, from: dataFromServer)
              
                        onSuccess();
                   } catch let error { // 3
                       print("Error creating obj from JSON because: \(error.localizedDescription)")
                       onFailure("");
                   }
               }
               else{
                   
                   onFailure("");
               }
               
           }) { (error) in
               //Error Handling
               onFailure("");
           }
       }

    
    func getTypesOfCells() -> [ListingTypes] {
        var types : [ListingTypes] = [];
        
        types.append(.details)
        
        if self.credits != nil {
            types.append(.castAndCrew)
        }
        if self.similarMovies != nil {
            types.append(.similarMovies)
        }
        
        return types;
        
        
    }
}
