//
//  Color+AllColors.swift
//  BehnkeFoundation
//
//  Created by John Behnke on 2/1/25.
//

import SwiftUI

extension Color {
    /// Every built-in SwiftUI system color, from `.red` through `.white`.
    ///
    /// Used by ``randomColor(excludingNeutrals:)`` as its source palette.
    public static let allColors: [Color] = [
        .red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .pink, .brown, .gray, .black, .white
    ]

    /// ``allColors``, excluding the neutral, non-chromatic colors (`.black`, `.white`,
    /// `.gray`, and `.brown`) — just the vibrant hues.
    public static let vibrantColors: [Color] = [
        .red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .pink
    ]
}
