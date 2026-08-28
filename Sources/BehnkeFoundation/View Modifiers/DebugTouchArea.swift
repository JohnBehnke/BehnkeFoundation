//
//  DebugTouchArea.swift
//
//
//  Created by John Behnke on 8/27/26.
//

import SwiftUI

struct DebugTouchAreaModifier: ViewModifier {
    let color: Color

    @State private var taps: [CGPoint] = []

    private let maxTaps = 25

    func body(content: Content) -> some View {
#if DEBUG
        if DebugTools.isEnabled {
            content
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded { value in
                            taps.append(value.location)
                            if taps.count > maxTaps {
                                taps.removeFirst(taps.count - maxTaps)
                            }
                        }
                )
                .overlay {
                    ZStack {
                        ForEach(Array(taps.enumerated()), id: \.offset) { index, point in
                            Circle()
                                .fill(color)
                                .frame(width: 10, height: 10)
                                .opacity(opacity(forIndex: index))
                                .position(point)
                        }
                    }
                    .allowsHitTesting(false)
                }
        } else {
            content
        }
#else
        content
#endif
    }

    private func opacity(forIndex index: Int) -> Double {
        let age = taps.count - 1 - index
        return max(0.15, 1.0 - Double(age) * 0.08)
    }
}

extension View {
    /// Marks every point where a tap or drag actually lands within this view's real
    /// hit-test area — the region SwiftUI considers "inside" the view for touches, which
    /// can differ from its visual bounds because of `.contentShape`, padding, or an
    /// intentionally oversized tap target.
    ///
    /// Unlike ``debugFrame(_:label:showsSize:showsFill:)``, this doesn't draw a static
    /// shape — it accumulates markers empirically as you interact, showing the last 25
    /// touches with older ones fading out. Because it attaches directly to this view
    /// rather than a separate overlay, it observes the view's actual hit-testing, not a
    /// guess at it — so a tap that lands outside the visible content but still registers
    /// (say, because of `.contentShape(Rectangle())` on an oversized frame) still leaves
    /// a mark.
    ///
    /// Only active in `DEBUG` builds; a no-op in release. Respects ``DebugTools/isEnabled``.
    ///
    /// ```swift
    /// Button("Tap me") { }
    ///     .padding(40)
    ///     .contentShape(Rectangle())
    ///     .debugTouchArea()
    /// ```
    ///
    /// - Parameter color: The marker color. Defaults to `.red`.
    public func debugTouchArea(_ color: Color = .red) -> some View {
        modifier(DebugTouchAreaModifier(color: color))
    }
}
