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
}

extension UIView {

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
    
    func loadView() {
        let view = loadFromNib()
        view.frame = bounds
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
