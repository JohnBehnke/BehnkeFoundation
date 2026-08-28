//
//  Date+HumanReadableTimeAgo.swift
//
//
//  Created by John Behnke on 12/30/23.
//

import Foundation

extension Date {
    /// A localized, human-readable description of how long ago (or until) this date is,
    /// e.g. `"5 min. ago"` or `"in 2 days"`.
    ///
    /// Backed by `RelativeDateTimeFormatter`.
    public var humanReadableTimeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
