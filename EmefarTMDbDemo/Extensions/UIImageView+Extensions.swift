//
//  UIImageView+Extensions.swift
//  EmefarTMDbDemo
//
//  Created by Mervan Şahinkaya on 15.03.2022.
//  Copyright © 2022 Mervan Şahinkaya. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
 
    func setImage(urlString: String, quality: String = "w500"){
     
        let url = URL(string: Domain.assest + quality +  urlString)
        if urlString != "" {
            self.kf.setImage(with: url)
        }
    }
}
