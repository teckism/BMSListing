//
//  BMSListingDataController.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class BMSListingDataController: NSObject {
    
    private var welcome : Welcome?
    
    var arrayOfMovies : [Movie]?
    private var originalList : [Movie]?
    
    
    private(set) var arrayOfAllGenres : [Genre]?
    
    
    func getAllGenres(onSuccess:@escaping ()->Void , onFailure:@escaping (_ result: String)->Void)
    {
        APIManager.sharedInstance.httpGETCall(apiFor: .genres, params: [:], success: { (responseFromServer) in
            
            if let dataFromServer = responseFromServer as? Data {
            
                var dictFromServer : [String : Any] = [:]
                    
                    dictFromServer =  try! JSONSerialization.jsonObject(with: dataFromServer, options: .allowFragments) as! [String : Any]
                    let arrayOfGenres = dictFromServer["genres"] as? [[String : Any]] ?? []
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    
                    var genres : [Genre] = []
                    for genre in arrayOfGenres {
                        
                         guard let archived = try? decoder.decode(Genre.self, from: try!  JSONSerialization.data(
                                                   withJSONObject: genre,
                                                   options: .prettyPrinted
                                                   ))
                                                        else {
                                                           return
                                                   }
                                                   genres.append(archived)
                        
                    }
                    self.arrayOfAllGenres = genres
                    onSuccess();
                
            }
            else{
                
                onFailure("");
            }
            
        }) { (error) in
            //Error Handling
            onFailure("");
        }
        
        
    }
    
    func getNowPlayingMovies(onSuccess:@escaping ()->Void , onFailure:@escaping (_ result: String)->Void)
    {
        
        APIManager.sharedInstance.httpGETCall(apiFor: .movieListing, params: [:], success: { (responseFromServer) in
            
            
            if let dataFromServer = responseFromServer as? Data {
                do {
                    // 1
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    // 2
                    self.welcome = try decoder.decode(Welcome.self, from: dataFromServer)
                    self.arrayOfMovies = self.welcome?.results
                    
                    self.originalList = self.welcome?.results
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
    
    
    
    func performSearch(searchText  : String){
        
        let arrayOfWordsInSearchText = searchText.components(separatedBy: " ")
        
        let arrayOfWordsInSearchTextUpperCased : Set = Set(arrayOfWordsInSearchText.map { $0.uppercased() })
        
        var filteredList : [Movie] = [];
        
        for movie in self.originalList ?? [] {
            
            // If any of the words in movie starts with exactly same text as the search Text
            
            let arrayOfWordsInMovieTitle  : [String] = (movie.title?.components(separatedBy: " ")) ?? []
            let arrayOfWordsInMovieTitleUppercased  : Set = Set(arrayOfWordsInMovieTitle.map { $0.uppercased() })
            
            
            
            
            if arrayOfWordsInMovieTitle.filter({$0.uppercased().hasPrefix(searchText.uppercased())}).count > 0
            {
                filteredList.append(movie)
                continue
            }
            
            
            //If words in search text appear anywer in the search text
            //This can be included in the above if condition itself
            
            
            if arrayOfWordsInMovieTitleUppercased.isSuperset(of: arrayOfWordsInSearchTextUpperCased){
                
                filteredList.append(movie)
            }
        }
        
        self.arrayOfMovies = filteredList
        
    }
}
