//
//  MovieProvider.swift
//  bestsourceofmovies
//
//  Created by Vadim on 01/05/2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import Foundation

typealias MovieProviderCompletionHandler = (Result<[MoviePreviewStruct]>) -> ()

class MovieProvider {
    var apiClient = ApiClient()
    var coreDataManager = CoreDataManager()
    var parser = MovierParser()
    
    public func discoverMovies(page: Int, removePrevious: Bool, completion: @escaping MovieProviderCompletionHandler) {
        var moviesArray: [MoviePreviewStruct]?
        
        apiClient.loadMovies(page: page, completion: { result in DispatchQueue.main.async {
            switch result {
            case .success(let data):
                moviesArray = self.parser.parseMoviesPreviwe(json: data);
                self.coreDataManager.save(moviesArray!, removePrevious: removePrevious)
                completion(.success(moviesArray!))
            case .failure(let error):
                completion(.failure(error))
            } } });
    }
    
    public func searchMovies(page: Int, q: String, completion: @escaping MovieProviderCompletionHandler) {
        var moviesArray: [MoviePreviewStruct]?
        
        apiClient.searchMovies(page: page, q: q, completion: { result in DispatchQueue.main.async {
            switch result {
            case .success(let data):
                moviesArray = self.parser.parseMoviesPreviwe(json: data);
                completion(.success(moviesArray!))
            case .failure(let error):
                completion(.failure(error))
            } } });
    }
    
    public func fetchMovies() -> [MoviePreviewStruct]? {
        var moviesArray = [MoviePreviewStruct]()
        let movies = coreDataManager.fetchNews()
        
        if (movies.count == 0) {
            return nil
        }
        
        movies.forEach { movie in
            let movieStruct = MoviePreviewStruct(id: movie.id, voteCount: movie.voteCount, posterPath: movie.posterPath, isAdult: movie.isAdult, overview: movie.overview, releaseDate: movie.releaseDate, originalTitle: movie.originalTitle, originalLang: movie.originalLang, title: movie.title, popularity: movie.popularity, isVideo: movie.isVideo, voteAvg: movie.voteAvg)
            
            moviesArray.append(movieStruct)
        }
        
        return moviesArray
    }
}
