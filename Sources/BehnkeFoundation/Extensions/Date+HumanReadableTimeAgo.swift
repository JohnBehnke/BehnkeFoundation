//
//  Date+HumanReadableTimeAgo.swift
//
//
//  Created by John Behnke on 12/30/23.
//

import Foundation

extension Date {
    public var humanReadableTimeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
