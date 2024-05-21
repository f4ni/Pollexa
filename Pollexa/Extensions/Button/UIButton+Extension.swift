//
//  UIButton+Extension.swift
//  Pollexa
//
//  Created by furkan icoz on 20.05.2024.
//

import UIKit

extension UIButton {
    func setImage(_ image: UIImage?, animated: Bool = false, reversed: Bool = false, color: UIColor) {
        guard animated else {
            setImage(image, for: .normal)
            return
        }
        
        let templateImage = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
        
        
        var values: [CATransform3D] = []
        var keyTimes: [Float] = []
        
        // Start scale
        if !reversed {
            values.append(CATransform3DMakeScale(0.0, 0.0, 0.0))
        } else {
            values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
        }
        keyTimes.append(0.0)

        // Bounce scale
        if !reversed {
            values.append(CATransform3DMakeScale(1.35, 1.35, 1.35))
        } else {
            values.append(CATransform3DMakeScale(0.65, 0.65, 0.65))
        }
        keyTimes.append(0.5)
        
        // End scale
        if !reversed {
            values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
        } else {
            values.append(CATransform3DMakeScale(0.0001, 0.0001, 0.0001))
        }
        keyTimes.append(1.0)
        
        // Animation
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.values = values.map({ NSValue(caTransform3D: $0) })
        animation.keyTimes = keyTimes.map({ NSNumber(value: $0 as Float) })
        animation.isRemovedOnCompletion = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        imageView?.layer.add(animation, forKey: "animateContents")
        
        setImage(templateImage, for: .normal)
    }
}
