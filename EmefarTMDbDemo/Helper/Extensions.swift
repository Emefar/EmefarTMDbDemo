//
//  Extensions.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.
//

import UIKit
import Kingfisher
import Lottie

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 15, weight: .thin)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }
}

extension UIImageView {
 
    func setImage(urlString: String, quality: String = "w500"){
     
        let url = URL(string: Domain.assest + quality +  urlString)
        if urlString != "" {
            self.kf.setImage(with: url)
        }
    }
}

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


extension AnimationView {
    func showLoading(onView : UIView) {
        let background = UIView(frame: onView.frame)
        background.backgroundColor = UIColor.white.withAlphaComponent(0.45)
        self.animation = Animation.named("loading")
        self.frame = CGRect(x: (onView.frame.width/2)-30 , y: (onView.frame.height/2)-30, width: 60, height: 60)
        let label = UILabel(frame: CGRect(x: self.center.x - 30, y: self.center.y + 30, width: 80, height: 15))
        label.text = "Wait a second.."
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        self.contentMode = .scaleAspectFill
        self.loopMode = .loop
        background.alpha = 0
        DispatchQueue.main.async {
            background.addSubview(self)
            onView.addSubview(background)
            background.addSubview(label)
        }
        UIView.animate(withDuration: 0.25) {
            background.alpha = 1
        }
        self.backgroundBehavior = .pauseAndRestore
        self.play()
    }

    
    func stopAnimation() {
        self.stop()
        self.superview?.removeFromSuperview()
    }
}


extension String {
  var isEmail: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }
}
