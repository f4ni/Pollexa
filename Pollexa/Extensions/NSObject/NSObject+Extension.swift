//
//  NSObject+Extension.swift
//  Pollexa
//
//  Created by furkan icoz on 18.05.2024.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        String(describing: self)
    }
}
