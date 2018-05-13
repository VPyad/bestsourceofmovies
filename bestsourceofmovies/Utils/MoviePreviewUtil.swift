//
//  MoviePreviewUtil.swift
//  bestsourceofmovies
//
//  Created by Vadim on 13/05/2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import UIKit

class MoviePreviewUtil {
    class func formatVoteNumber(votes: Int32) -> String {
        let formatter = NumberFormatter()
        
        formatter.groupingSeparator = " "
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        
        let votesStr = formatter.string(from: NSNumber(integerLiteral: Int(votes)))
        return votesStr!
    }
    
    class func formatReleaseDate(date: NSDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        
        let releaseDateStr = formatter.string(from: date as Date)
        return releaseDateStr
    }
}
