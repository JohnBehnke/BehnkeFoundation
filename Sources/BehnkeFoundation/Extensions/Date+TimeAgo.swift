//
//  Date+TimeAgo.swift
//
//
//  Created by John Behnke on 12/30/23.
//

import Foundation

extension Date {
    public var timeAgo: TimeInterval { -timeIntervalSinceNow }
}
