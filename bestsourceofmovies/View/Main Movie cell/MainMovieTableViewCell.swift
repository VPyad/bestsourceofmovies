//
//  MainMovieTableViewCell.swift
//  bestsourceofmovies
//
//  Created by Vadim on 13/05/2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import UIKit

class MainMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterUIImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func justTestFunc() {
        
    }
}
