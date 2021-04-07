//
//  MovieViewCell.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.
//  Copyright © 2021 Emefar. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var movieItem: Movie? {
        
        didSet {
            
            if let movie = movieItem {
                
                self.titleLabel.text = movie.title ?? ""
                
                let releaseDate = movie.release_date ?? ""
                if releaseDate != "" {
                    self.titleLabel.text = (movie.title ?? "") + " (" + releaseDate + ")"
                }

            }
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
