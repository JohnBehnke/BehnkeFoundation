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
    /// Used by ``randomColor()`` as its source palette.
    public static let allColors: [Color] = [
        .red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .pink, .brown, .gray, .black, .white
    ]
}
