//
//  MovieParser.swift
//  bestsourceofmovies
//
//  Created by Vadim on 30/04/2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovierParser {
    public func parseMoviesPreviwe(json: Any) -> [MoviePreviewStruct] {
        var moviesArray: [MoviePreviewStruct] = [];
        var jsonDic = JSON(json);
        let movies = jsonDic["results"].arrayValue;
        
        movies.forEach { movie in
            
            let id = movie["id"].int64Value;
            let isAdult = movie["adult"].boolValue;
            let isVideo = movie["video"].boolValue;
            let originalLang = movie["original_language"].stringValue;
            let originalTitle = movie["original_title"].stringValue;
            let overview = movie["overview"].stringValue;
            let popularity = movie["popularity"].floatValue;
            let title = movie["title"].stringValue;
            let voteAvg = movie["vote_average"].floatValue;
            let voteCount = movie["vote_count"].int32Value;
            
            var posterPath: String?;
            posterPath = movie["poster_path"].stringValue;
            posterPath = (posterPath ?? "").isEmpty ? "https://wingslax.com/wp-content/uploads/2017/12/no-image-available.png" : ApiClient().getPosterPath(path: posterPath!);
            
            let dateFormatter = DateFormatter();
            dateFormatter.dateFormat = "yyyy-MM-dd";
            let releaseDate = dateFormatter.date(from: movie["release_date"].stringValue) as! NSDate;
            
            let movie = MoviePreviewStruct(id: id, voteCount: voteCount, posterPath: posterPath, isAdult: isAdult, overview: overview, releaseDate: releaseDate, originalTitle: originalTitle, originalLang: originalLang, title: title, popularity: popularity, isVideo: isVideo, voteAvg: voteAvg)
            
            moviesArray.append(movie);
        }
        
        return moviesArray;
    }
}
