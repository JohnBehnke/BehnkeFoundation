//
//  Color+RandomColor.swift
//  BehnkeFoundation
//
//  Created by John Behnke on 2/1/25.
//

import SwiftUI

extension Color {
    /// Returns a random color from ``allColors``.
    ///
    /// - Parameter excludingNeutrals: When `true`, picks from ``vibrantColors`` instead —
    ///   skipping `.black`, `.white`, `.gray`, and `.brown`. Defaults to `false`.
    public static func randomColor(excludingNeutrals: Bool = false) -> Color {
        let palette = excludingNeutrals ? vibrantColors : allColors
        return palette.randomElement() ?? .red
    }
}
