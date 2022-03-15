//
//  MovieViewCell.swift
//  EmefarTMDbDemo
//
//  Created by Mervan Şahinkaya on 15.03.2022.
//  Copyright © 2022 Mervan Şahinkaya. All rights reserved.
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
