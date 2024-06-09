//
//  NSObject+Extension.swift
//  Pollexa
//
//  Created by furkan icoz on 18.05.2024.
//

import UIKit

extension NSObject {
    class var nameOfClass: String {
        String(describing: self)
    }
    
    func getNib() -> UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
}
