//
//  SettingsIcon.swift
//
//
//  Created by John Behnke on 12/30/23.
//

import SwiftUI

struct SettingsIconModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    let color: Color

    func body(content: Content) -> some View {
        content
            .frame(width: 20, height: 20)
            .imageScale(.medium)
            .padding(5)
            .background(color.gradient)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
            .shadow(color: color.opacity(colorScheme == .dark ? 0.5 : 0), radius: 3)
    }
}

extension View {
    /// Styles this view (typically an SF Symbol `Image`) as a rounded, colored icon
    /// tile, matching the look of a row icon in the Settings app.
    ///
    /// ```swift
    /// Image(systemName: "gear")
    ///     .settingsIcon(.gray)
    /// ```
    ///
    /// - Parameter color: The tile's background gradient (and glow shown behind it in
    ///   dark mode) color.
    public func settingsIcon(_ color: Color) -> some View {
        modifier(SettingsIconModifier(color: color))
    }
}

#Preview {
    VStack(spacing: 12) {
        HStack(spacing: 12) {
            Image(systemName: "gear")
                .settingsIcon(.gray)
            Image(systemName: "bell.fill")
                .settingsIcon(.red)
            Image(systemName: "wifi")
                .settingsIcon(.blue)
            Image(systemName: "person.fill")
                .settingsIcon(.orange)
        }
    }
    .padding()
}
