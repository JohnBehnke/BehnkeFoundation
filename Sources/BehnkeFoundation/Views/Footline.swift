//
//  Footline.swift
//
//
//  Created by John Behnke on 8/5/23.
//

import SwiftUI

/// A small "made with" footer showing the app's name, version, and build number,
/// plus a playful line crediting who built it.
///
/// The credit line has three states, controlled by ``Origin``: entirely human-made,
/// a human-and-AI collaboration, or entirely AI-made ("vibe coded"). By default the
/// credit line is tappable and cycles its icon through a random color as a small
/// easter egg; disable that with `isInteractive`.
///
/// ```swift
/// Footline()
/// Footline(origin: .assisted(agents: [.claude, .codex]))
/// Footline(origin: .agent(agents: [.claude, .codex]))
/// ```
public struct Footline: View {
    let appName: String = Bundle.main.appName
    let releaseVersion: String = Bundle.main.releaseVersionNumber
    let buildVersion: String = Bundle.main.buildVersionNumber
    let locationName: String
    let origin: Origin
    let symbolName: String?
    let isInteractive: Bool
    let symbolColor: Color

    /// Creates a footer view.
    ///
    /// - Parameters:
    ///   - locationName: Where the app was made. Shown in bold within the credit line.
    ///   - origin: Who made it — human, AI-assisted, or fully AI-made. Defaults to ``Origin/human``.
    ///   - symbolName: The SF Symbol name shown next to the credit line. Pass `nil` (the
    ///     default) to use ``Origin``'s own default — a heart for `.human`/`.assisted`,
    ///     no icon at all for `.agent`.
    ///   - isInteractive: Whether tapping the credit line cycles the icon through a random
    ///     color and plays a haptic. When `false`, the icon renders flat with no shadow,
    ///     gradient, or animation, and the row isn't a button at all.
    ///   - symbolColor: The icon's color. When `isInteractive` is `false`, this is the icon's
    ///     fixed color. When `isInteractive` is `true`, this is only the color shown before
    ///     the first tap — tapping randomizes it from there. Defaults to `.red`.
    public init(
        locationName: String = "Maine",
        origin: Origin = .human,
        symbolName: String? = nil,
        isInteractive: Bool = true,
        symbolColor: Color = .red
    ) {
        self.locationName = locationName
        self.origin = origin
        self.symbolName = symbolName ?? origin.display.defaultSymbolName
        self.isInteractive = isInteractive
        self.symbolColor = symbolColor
    }

    public var body: some View {
        VStack(spacing: 4) {
            Text("\(self.appName) \(self.releaseVersion) (\(self.buildVersion))")
                .font(.caption2)
                .foregroundStyle(.secondary)
            AttributionButton(locationName: locationName, origin: origin, symbolName: symbolName, isInteractive: isInteractive, symbolColor: symbolColor)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

extension Footline {
    /// An AI model or tool credited in the footer's "assisted by" / "vibe coded" line.
    ///
    /// A few common ones ship as static presets (``claude``, ``codex``, ``copilot``,
    /// ``gemini``), but you can credit anything else directly:
    ///
    /// ```swift
    /// Footline.Agent(name: "Llama")
    /// ```
    public struct Agent: Sendable, Hashable {
        /// The display name shown in the footer, e.g. `"Claude"`.
        public let name: String

        /// Creates a custom agent with the given display name.
        public init(name: String) {
            self.name = name
        }

        /// Anthropic's Claude.
        public static let claude = Agent(name: "Claude")
        /// OpenAI's Codex.
        public static let codex = Agent(name: "Codex")
        /// GitHub Copilot.
        public static let copilot = Agent(name: "Copilot")
        /// Google's Gemini.
        public static let gemini = Agent(name: "Gemini")
    }

    /// Who made the app — controls the wording and default icon of ``Footline``'s credit line.
    public enum Origin: Sendable {
        /// Entirely human-made. Renders as "Made by hand in ⟨location⟩ with ❤️".
        case human

        /// A human-and-AI collaboration. Renders as "Made mostly by hand in ⟨location⟩
        /// with ❤️", with an italicized "Assisted by ⟨agents⟩" line underneath.
        ///
        /// Pass an empty array to keep the "assisted" wording without naming any agents.
        case assisted(agents: [Agent])

        /// Entirely AI-made. Renders as "Vibe coded in ⟨location⟩ by ⟨agents⟩", with no
        /// icon shown by default.
        ///
        /// Pass an empty array to keep the "vibe coded" wording without naming any agents.
        case agent(agents: [Agent])

        struct Display {
            let headline: String
            let connector: String
            let subline: String?
            let inlineAgents: String?
            let defaultSymbolName: String?

            var connectorLine: String {
                "\(connector)\(inlineAgents.map { " \($0)" } ?? "")"
            }
        }

        var display: Display {
            switch self {
            case .human:
                Display(headline: "Made by hand", connector: "with", subline: nil, inlineAgents: nil, defaultSymbolName: "heart.fill")
            case .assisted(let agents):
                Display(
                    headline: "Made mostly by hand",
                    connector: "with",
                    subline: agents.isEmpty ? nil : "Assisted by \(Self.formatted(agents))",
                    inlineAgents: nil,
                    defaultSymbolName: "heart.fill"
                )
            case .agent(let agents):
                Display(
                    headline: "Vibe coded",
                    connector: "by",
                    subline: nil,
                    inlineAgents: agents.isEmpty ? nil : Self.formatted(agents),
                    defaultSymbolName: nil
                )
            }
        }

        private static func formatted(_ agents: [Agent]) -> String {
            switch agents.count {
            case 0: ""
            case 1: agents[0].name
            case 2: "\(agents[0].name) & \(agents[1].name)"
            default:
                "\(agents.dropLast().map(\.name).joined(separator: ", ")) & \(agents.last!.name)"
            }
        }
    }
}

private struct AttributionButton: View {
    @State private var isPressed: Bool = false
    @State private var numberOfPresses: Int = 0
    @State private var symbolColor: Color

    private let pressedScale: CGFloat = 0.75
    private let pressedShadowRadius: CGFloat = 3
    private let restingShadowRadius: CGFloat = 1
    private let rotationDegrees: Double = 10
    private let pressAnimation: Animation = .spring(response: 0.2, dampingFraction: 0.1)
    private let unpressDelay: Duration = .seconds(0.2)

    let locationName: String
    let origin: Footline.Origin
    let symbolName: String?
    let isInteractive: Bool

    init(locationName: String, origin: Footline.Origin, symbolName: String?, isInteractive: Bool, symbolColor: Color) {
        self.locationName = locationName
        self.origin = origin
        self.symbolName = symbolName
        self.isInteractive = isInteractive
        self._symbolColor = State(initialValue: symbolColor)
    }

    var body: some View {
        if isInteractive {
            Button {
                symbolColor = .randomColor(excludingNeutrals: true)
                numberOfPresses += 1
                isPressed.toggle()
                Task {
                    try? await Task.sleep(for: unpressDelay)
                    isPressed.toggle()
                }
            } label: {
                content(animatesSymbol: true)
            }
            .buttonStyle(.plain)
            .accessibilityHint(symbolName != nil ? "Changes the icon's color" : "")
#if os(iOS)
            .sensoryFeedback(.impact, trigger: isPressed)
#endif
        } else {
            content(animatesSymbol: false)
        }
    }

    @ViewBuilder
    private func content(animatesSymbol: Bool) -> some View {
        let display = origin.display
        VStack(spacing: 2) {
            HStack(alignment: .center, spacing: 2) {
                Text("\(display.headline) in ") + Text(locationName).bold() + Text(" \(display.connectorLine)")
                if let symbolName {
                    if animatesSymbol {
                        Image(systemName: symbolName)
                            .font(.caption2)
                            .shadow(color: symbolColor, radius: isPressed ? pressedShadowRadius : restingShadowRadius)
                            .foregroundStyle(symbolColor.gradient)
                            .scaleEffect(isPressed ? pressedScale : 1.0)
                            .rotationEffect(isPressed ? .degrees(numberOfPresses.isMultiple(of: 2) ? rotationDegrees : -rotationDegrees) : .degrees(0))
                            .animation(pressAnimation, value: isPressed)
                            .accessibilityHidden(true)
                    } else {
                        Image(systemName: symbolName)
                            .font(.caption2)
                            .foregroundStyle(symbolColor)
                            .accessibilityHidden(true)
                    }
                }
            }
            if let subline = display.subline {
                Text(subline)
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                    .italic()
            }
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        Footline(locationName: "The Matrix")
        Footline(locationName: "The Matrix", origin: .assisted(agents: [.claude, .codex]))
        Footline(locationName: "The Matrix", origin: .agent(agents: [.claude, .codex]))
        Footline(locationName: "The Matrix", isInteractive: false, symbolColor: .blue)
    }
}
