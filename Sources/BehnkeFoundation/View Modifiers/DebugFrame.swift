//
//  ViewDebugModifier.swift
//
//
//  Created by John Behnke on 12/30/23.
//
//  https://mastodon.social/@isurujn/111652511093268918
//

import SwiftUI

struct ViewDebugModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .border(color, width: 1)
    }
}

extension View {
    func debugFrame(_ color: Color = .red) -> some View {
        modifier(ViewDebugModifier(color: color))
    }
}
