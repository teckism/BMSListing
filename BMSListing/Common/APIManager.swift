//
//  APIManager.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

//Use of enum to allow only specific apis to be accessed by other classes
enum APIAvailable {
    case movieListing
    case genres
    case movieDetails(movieId : Int);
    case movieCredits(movieId : Int)
    case similarMovies(movieId : Int)
}


public class APIManager: NSObject {
    static let sharedInstance = APIManager();
      
    private override init() {}
    
    func httpPOSTCall(apiFor:APIAvailable,params : NSDictionary,  success:@escaping (_ serverResponse: Any) ->(), failure:@escaping (_ error: NSError) ->())
    {
        
       var strUrl = Constants.BaseUrls.kAPIBaseUrl +
               getAPIForEnum(availableAPI: apiFor) + "?";
               let queryParams =  (params as! Dictionary<String, Any>).queryParameters
               if queryParams != "" {
                   strUrl += "&";
               }
                strUrl += "api_key=" + Constants.ApiKeys.kApiKey;
               
               
              
        
        let url = URL(string: strUrl)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.httpShouldHandleCookies = true
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        
        
        do {
            let payload = try JSONSerialization.data(withJSONObject: params)
            request.httpBody = payload
            
            request.encodeParameters(parameters: params as! [String : String])
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if ((error) == nil)
                {
                    
                    success(data as Any)
                }
                else{
                    let userInfo: [AnyHashable : Any] =
                        [
                            
                            NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: Constants.Alerts.kUnableToReachServer, comment: "") ,
                            
                            NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: Constants.Alerts.ERROR_KEY, comment: "")
                    ]
                    let err = NSError(domain: "BMSHttpResponseErrorDomain", code: 500, userInfo: userInfo as? [String : Any])
                    
                    failure(err);
                }
            }.resume()
            
        }
        catch{
            failure(error as NSError);
            print(error.localizedDescription)
        }
    }
    
    
    func httpGETCall(apiFor:APIAvailable,params : NSDictionary,  success:@escaping (_ serverResponse: Any) ->(), failure:@escaping (_ error: NSError) ->())
    {
        var strUrl = Constants.BaseUrls.kAPIBaseUrl +
            getAPIForEnum(availableAPI: apiFor) + "?";
        let queryParams =  (params as! Dictionary<String, Any>).queryParameters
        if queryParams != "" {
            strUrl += "&";
        }
        strUrl += "api_key=" + Constants.ApiKeys.kApiKey;
        
        
        let url = URL(string: strUrl)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.httpShouldHandleCookies = true
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if ((error) == nil)
            {
                    success(data)

            }
            else{
                let userInfo: [AnyHashable : Any] =
                    [
                        
                        NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: Constants.Alerts.kUnableToReachServer, comment: "") ,
                        
                        NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: Constants.Alerts.ERROR_KEY, comment: "")
                ]
                let err = NSError(domain: "BMSHttpResponseErrorDomain", code: 500, userInfo: userInfo as? [String : Any])
                
                failure(err);
            }
            
        }.resume()
        
    }
}



private func getAPIForEnum(availableAPI : APIAvailable)->String {
    
    
    switch availableAPI {
    case .movieListing:
        return Constants.WebServices.kGetMovieListing
        
    case .genres:
        return Constants.WebServices.kGetGenres
    case .movieDetails(let value):
        return Constants.WebServices.kGetMovieDetails + "\(value)"
    case .movieCredits(let movieId):
        return Constants.WebServices.kMovieCredits.replacingOccurrences(of: "{movie_id}", with: "\(movieId)")
        
        
    case .similarMovies(let movieId):
        return Constants.WebServices.kSimilarMovies.replacingOccurrences(of: "{movie_id}", with: "\(movieId)")
    }
}
