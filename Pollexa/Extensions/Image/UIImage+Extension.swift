//
//  UIImage+Extension.swift
//  Pollexa
//
//  Created by Furkan ic on 9.06.2024.
//

import UIKit

extension UIImage {
    class var thumbCircleFill: UIImage? {
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.accent, .white])
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        let image = UIImage(
            systemName: "hand.thumbsup.circle.fill",
            withConfiguration: colorConfig.applying(sizeConfig)
        )
        return image
    }
    
    class var placeHolder: UIImage {
        UIImage(systemName: "photo")!
    }
}
