//
//  UIView+Extension.swift
//  Pollexa
//
//  Created by furkan icoz on 18.05.2024.
//

import UIKit

extension UIView {
    func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).nameOfClass
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self).first as? UIView ?? UIView()
        
        return view
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.masksToBounds = newValue != 0
            layer.cornerRadius = newValue
        }
    }
}
