//
//  DebugTrace.swift
//
//
//  Created by John Behnke on 8/27/26.
//

import SwiftUI

#if DEBUG
@MainActor
private enum DebugTraceCounter {
    private static var counts: [String: Int] = [:]

    static func log(_ label: String) {
        let count = (counts[label] ?? 0) + 1
        counts[label] = count
        print("🔍 [\(count)] \(label) re-evaluated")
    }
}
#endif

extension View {
    /// Prints a message to the console, with a running count, every time this point in
    /// the view hierarchy re-evaluates — useful for spotting unnecessary re-renders.
    ///
    /// Only active in `DEBUG` builds; a no-op in release. Set ``DebugTools/isEnabled`` to
    /// `false` to silence every `debugTrace()` in the app at once without removing calls.
    ///
    /// ```swift
    /// Text("Hello")
    ///     .debugTrace("Hello text")
    /// ```
    ///
    /// - Parameter label: A name to identify this call site in the console output.
    public func debugTrace(_ label: String) -> some View {
#if DEBUG
        if DebugTools.isEnabled {
            DebugTraceCounter.log(label)
        }
#endif
        return self
    }
}
