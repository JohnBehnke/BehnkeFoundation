//
//  Date+HumanReadableTimeAgo.swift
//
//
//  Created by John Behnke on 12/30/23.
//

import Foundation

extension Date {
    public var humanReadableTimeAgo: String {
        let interval = -self.timeIntervalSinceNow
        if interval < 60 {
            return "just now"
        } else if interval < 3600 {
            let minutes = Int(interval / 60)
            return "\(minutes) min\(minutes > 1 ? "s" : "") ago"
        } else if interval < 86400 {
            let hours = Int(interval / 3600)
            return "\(hours) hr\(hours > 1 ? "s" : "") ago"
        } else if interval < 604800 {
            let days = Int(interval / 86400)
            return "\(days) day\(days > 1 ? "s" : "") ago"
        } else if interval < 2592000 {
            let weeks = Int(interval / 604800)
            return "\(weeks) week\(weeks > 1 ? "s" : "") ago"
        } else if interval < 31536000 {
            let months = Int(interval / 2592000)
            return "\(months) month\(months > 1 ? "s" : "") ago"
        } else {
            let years = Int(interval / 31536000)
            return "\(years) year\(years > 1 ? "s" : "") ago"
        }
    }
}
