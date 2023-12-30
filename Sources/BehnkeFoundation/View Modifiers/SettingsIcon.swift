//
//  SettingIcon.swift
//
//
//  Created by John Behnke on 12/30/23.
//

import Foundation
import SwiftUI

struct SettingsIcon: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: 20, height: 20)
            .imageScale(.medium)
            .padding(5)
            .background(color.gradient)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
            .shadow(color: color.opacity(colorScheme == .dark ? 0.5 : 0), radius: 3)
        
    }
}

extension View {
    func settingsIcon(_ color: Color) -> some View {
        modifier(SettingsIcon(color: color))
    }
}
