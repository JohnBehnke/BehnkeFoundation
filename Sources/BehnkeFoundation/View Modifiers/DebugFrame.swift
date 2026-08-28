//
//  DebugFrame.swift
//
//
//  Created by John Behnke on 12/30/23.
//
//  https://mastodon.social/@isurujn/111652511093268918
//

import SwiftUI

struct DebugFrameModifier: ViewModifier {
    let color: Color
    let label: String?
    let showsSize: Bool
    let showsFill: Bool

    func body(content: Content) -> some View {
#if DEBUG
        if DebugTools.isEnabled {
            content
                .background {
                    if showsFill {
                        color.opacity(0.15)
                    }
                }
                .overlay {
                    GeometryReader { proxy in
                        Rectangle()
                            .strokeBorder(color, style: StrokeStyle(lineWidth: 1, dash: [4, 2]))
                            .overlay(alignment: .topLeading) {
                                if showsSize || label != nil {
                                    tag(size: proxy.size)
                                }
                            }
                    }
                }
        } else {
            content
        }
#else
        content
#endif
    }

    @ViewBuilder
    private func tag(size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 1) {
            if let label {
                Text(label)
            }
            if showsSize {
                Text("\(Int(size.width))×\(Int(size.height))")
            }
        }
        .font(.system(size: 9, weight: .semibold, design: .monospaced))
        .foregroundColor(.white)
        .padding(.horizontal, 3)
        .padding(.vertical, 1)
        .background(color)
        .cornerRadius(2)
    }
}

extension View {
    /// Draws a colored border around this view to help debug layout — sizing, padding,
    /// stack alignment, and so on.
    ///
    /// Only active in `DEBUG` builds; in release builds this is a no-op, so it's safe to
    /// leave calls in place without worrying about them shipping. Set ``DebugTools/isEnabled``
    /// to `false` to silence every `debugFrame()` in the app at once without removing calls.
    ///
    /// ```swift
    /// MyView()
    ///     .debugFrame()
    ///     .debugFrame(.blue, label: "Header")
    ///     .debugFrame(.green, showsSize: false, showsFill: true)
    /// ```
    ///
    /// - Parameters:
    ///   - color: The border, tag, and (if enabled) fill color. Defaults to `.red`.
    ///   - label: An optional tag shown in the corner to identify this view when several
    ///     `debugFrame()` calls are nested. Defaults to `nil`.
    ///   - showsSize: Whether to overlay the view's rendered width × height. Defaults to `true`.
    ///   - showsFill: Whether to tint the view's background with a translucent fill, useful
    ///     for views with no visible background of their own. Defaults to `false`.
    public func debugFrame(
        _ color: Color = .red,
        label: String? = nil,
        showsSize: Bool = true,
        showsFill: Bool = false
    ) -> some View {
        modifier(DebugFrameModifier(color: color, label: label, showsSize: showsSize, showsFill: showsFill))
    }
}
