//
//  ApiClient.swift
//  bestsourceofmovies
//
//  Created by Vadim on 30/04/2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import Foundation
import Alamofire
import SwiftHTTP
import SwiftyJSON

enum Result<T> {
    case success(T)
    case failure(Error)
}

typealias MovieCompletionHandler = (Result<Any>) -> ()

class ApiClient {
    let baseUrl = "https://api.themoviedb.org/3/";
    let apiKey = "6ccd72a2a8fc239b13f209408fc31c33";
    let discoverPath = "discover/movie";
    let searchPath = "search/movie";
    public let baseImageUrl = "http://image.tmdb.org/t/p/w185";
    
    public func getPosterPath(path: String) -> String {
        let url = baseImageUrl + path;
        return url;
    }
    
    public func loadMovies(page: Int, completion: @escaping MovieCompletionHandler) {
        Alamofire.request(baseUrl + discoverPath,
                          parameters: ["api_key": apiKey,
                                       "language": "en-US",
                                       "sort_by": "popularity.desc",
                                       "include_adult": "true",
                                       "include_video": "false",
                                       "page": page]).validate().responseJSON { response in
                            switch response.result {
                            case .success:
                                completion(.success(response.result.value!))
                            case .failure(var error):
                                error = response.result.error!
                                completion(.failure(error))
                            }
        }
    }
    
    public func searchMovies(page: Int, q: String, completion: @escaping MovieCompletionHandler) {
        Alamofire.request(baseUrl + searchPath,
                          parameters: ["api_key": apiKey,
                                       "query": q,
                                       "language": "en-US",
                                       "sort_by": "popularity.desc",
                                       "include_adult": "true",
                                       "include_video": "false",
                                       "page": page]).validate().responseJSON { response in
                            switch response.result {
                            case .success:
                                completion(.success(response.result.value!))
                            case .failure(var error):
                                error = response.result.error!
                                completion(.failure(error))
                            }
        }
    }
}
