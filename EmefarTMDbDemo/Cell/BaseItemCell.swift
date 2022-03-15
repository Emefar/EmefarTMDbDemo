//
//  BaseItemCell.swift
//  EmefarTMDbDemo
//
//  Created by Mervan Şahinkaya on 15.03.2022.
//  Copyright © 2022 Mervan Şahinkaya. All rights reserved.
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
