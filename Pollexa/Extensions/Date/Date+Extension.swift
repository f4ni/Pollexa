//
//  Date+Extension.swift
//  Pollexa
//
//  Created by Furkan ic on 9.06.2024.
//

import Foundation

extension Date {
    var timeAgoDisplay: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
