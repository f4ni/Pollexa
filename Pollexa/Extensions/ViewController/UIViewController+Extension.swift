//
//  UIViewController+Extension.swift
//  Pollexa
//
//  Created by furkan icoz on 19.05.2024.
//

import UIKit

extension UIViewController {
    func navigationBarFrame() -> CGRect {
        let topOffset = navigationController?.view.safeAreaInsets.top ?? 0
        
        let frame = CGRect(
            x: 0,
            y: -topOffset,
            width: navigationController?.navigationBar.bounds.width ?? 0,
            height: 116 + topOffset
        )
        
        return frame
    }
}
