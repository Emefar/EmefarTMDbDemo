//
//  Lottie+Extensions.swift
//  EmefarTMDbDemo
//
//  Created by Mervan Şahinkaya on 15.03.2022.
//  Copyright © 2022 Emefar. All rights reserved.
//

import Foundation
import Lottie

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


