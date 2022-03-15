//
//  UIViewController+Extensions.swift
//  EmefarTMDbDemo
//
//  Created by Mervan Şahinkaya on 15.03.2022.
//  Copyright © 2022 Mervan Şahinkaya. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func cancelableBasicAlert(title: String, text:String, alert: UIAlertAction, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController: UIAlertController = {
            let alertControl = UIAlertController(title: title, message: text, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler)
            action.setValue(UIColor.red, forKey: "titleTextColor")
            alertControl.addAction(action)
            alertControl.addAction(alert)
            return alertControl
        }()
        
        present(alertController, animated: true, completion: nil)
    }
}
