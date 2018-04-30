//
//  MoviePreview+CoreDataProperties.swift
//  
//
//  Created by Vadim on 30/04/2018.
//
//

import Foundation
import CoreData


extension MoviePreview {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviePreview> {
        return NSFetchRequest<MoviePreview>(entityName: "MoviePreview")
    }

    @NSManaged public var id: Int64
    @NSManaged public var voteCount: Int32
    @NSManaged public var posterPath: String?
    @NSManaged public var isAdult: Bool
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var originalTitle: String?
    @NSManaged public var originalLang: String?
    @NSManaged public var title: String?
    @NSManaged public var popularity: Float
    @NSManaged public var isVideo: Bool
    @NSManaged public var voteAvg: Float

}
