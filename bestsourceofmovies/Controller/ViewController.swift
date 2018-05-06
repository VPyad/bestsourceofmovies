//
//  ViewController.swift
//  bestsourceofmovies
//
//  Created by Vadim on 30/04/2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*let client = ApiClient();
        let pasrer = MovierParser();
        
        client.loadMovies(page: 1, completion: { result in DispatchQueue.main.async {
            switch result {
            case .success(let data):
                let moviesArray = pasrer.parseMoviesPreviwe(json: data);
                moviesArray.forEach { movie in
                    print(movie.releaseDate!);
                    print(movie.posterPath!);
                }
                print(moviesArray.count);
            case .failure(let error):
                print(error);
            } } });*/
        
        searchMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func discoverMovies() {
        let movieProvider = MovieProvider()
        
        movieProvider.discoverMovies(page: 1, removePrevious: false, completion: { result in
            switch result {
            case .success(let movies):
                movies.forEach { movie in
                    print(movie.title!)
                    print(movie.releaseDate!)
                    print(movie.posterPath!)
                }
            case .failure(let error):
                print("error")
            }
        })
    }
    
    private func loadMoviesFromCoreData() {
        let movieProvider = MovieProvider()
        
        let movies = movieProvider.fetchMovies()
        movies!.forEach { movie in
            print(movie.title!)
            print(movie.releaseDate!)
            print(movie.posterPath!)
        }
        
    }
    
    private func searchMovies() {
        let movieProvider = MovieProvider()
        
        movieProvider.searchMovies(page: 1, q: "Iron man", completion: { result in
            switch result {
            case .success(let movies):
                movies.forEach { movie in
                    print(movie.title!)
                    print(movie.releaseDate!)
                    print(movie.posterPath!)
                }
            case .failure(let error):
                print("error")
            }
        })
    }
}

