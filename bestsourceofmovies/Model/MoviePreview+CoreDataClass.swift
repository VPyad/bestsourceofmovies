//
//  MoviePreview+CoreDataClass.swift
//  
//
//  Created by Vadim on 30/04/2018.
//
//

import Foundation
import CoreData

//@objc(MoviePreview)
public class MoviePreview: NSManagedObject {
    
    class func create(in context: NSManagedObjectContext) {
    }
}

struct MoviePreviewStruct {
    let id: Int64
    let voteCount: Int32
    let posterPath: String?
    let isAdult: Bool
    let overview: String?
    let releaseDate: NSDate?
    let originalTitle: String?
    let originalLang: String?
    let title: String?
    let popularity: Float
    let isVideo: Bool
    let voteAvg: Float
}

extension MoviePreview {
    @discardableResult
    convenience init(with moviePreview: MoviePreviewStruct, in context: NSManagedObjectContext) {
        self.init(context: context)
        
        id = moviePreview.id
        voteCount = moviePreview.voteCount
        posterPath = moviePreview.posterPath
        isAdult = moviePreview.isAdult
        overview = moviePreview.overview
        releaseDate = moviePreview.releaseDate
        originalLang = moviePreview.originalLang
        originalTitle = moviePreview.originalTitle
        title = moviePreview.title
        popularity = moviePreview.popularity
        isVideo = moviePreview.isVideo
        voteAvg = moviePreview.voteAvg
    }
}
