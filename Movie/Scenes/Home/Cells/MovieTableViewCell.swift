//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Ali Can Batur on 06/07/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setFullWidthOfSeperator()
    }
    
    // MARK: - Population 
    
    /// Populates cell using movie object's information
    func populateCell(movie: Movie) {
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
        overviewLabel.text = movie.overview
        posterImageView.imageFromURL(url: movie.imageURL())
    }
    
}
