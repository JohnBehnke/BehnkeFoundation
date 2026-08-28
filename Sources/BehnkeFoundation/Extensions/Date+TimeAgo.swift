//
//  Date+TimeAgo.swift
//
//
//  Created by John Behnke on 12/30/23.
//

import Foundation

extension Date {
    /// The time interval between this date and now, in seconds.
    ///
    /// Positive for a date in the past, negative for a date in the future.
    public var timeAgo: TimeInterval { -timeIntervalSinceNow }
}
