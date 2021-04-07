//
//  BaseItemCell.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.
//  Copyright © 2021 Emefar. All rights reserved.
//

import UIKit

class BaseItemCell: UITableViewCell {
    
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var itemImg: UIImageView!
    
    var movieItem: Movie? {
        
        didSet {
            
            if let movie = movieItem {
                
                self.itemLbl.text = movie.title ?? ""
                self.itemImg.setImage(urlString: movie.poster_path ?? "", quality: "w185")
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
