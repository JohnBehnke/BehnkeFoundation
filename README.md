# BehnkeFoundation
A collection of SwiftUI Views and other Swift code that I use for all my apps.

## Contents

- [Installation](#installation)
- [Footline](#footline)
- [Debug Tools](#debug-tools)
- [Settings Icon](#settings-icon)
- [Color Extensions](#color-extensions)
- [Date Extensions](#date-extensions)

## Installation

### For Xcode Projects

File > Swift Packages > Add Package Dependency: https://github.com/JohnBehnke/BehnkeFoundation

### For Swift Packages

Add a dependency in your `Package.swift`

```swift
.package(url: "https://github.com/JohnBehnke/BehnkeFoundation.git", from: "1.0.0"),
```

## Footline

A "made with" footer showing the app's name, version, and build number, plus a credit
line for who built it — entirely by hand, human-and-AI collaboration, or fully AI-made
("vibe coded"). Tapping the credit line cycles its icon through a random color.

```swift
Footline()
Footline(origin: .assisted(agents: [.claude, .codex]))
Footline(origin: .agent(agents: [.claude, .codex]))
```

`Footline.Agent` ships presets for `.claude`, `.codex`, `.copilot`, and `.gemini`, but you
can credit anything else directly with `Footline.Agent(name: "Llama")`.

## Debug Tools

Three `DEBUG`-only view modifiers for layout and re-render debugging — no-ops in release
builds, so it's safe to leave calls in place.

```swift
MyView()
    .debugFrame()                      // dashed border + live width × height overlay
    .debugFrame(.blue, label: "Header") // custom color, tag to identify nested views
    .debugTrace("MyView")              // logs a running count to the console on every re-render
    .debugTouchArea()                  // marks where taps/drags actually land, vs. the visual bounds

DebugTools.isEnabled = false // silence every debugFrame/debugTrace/debugTouchArea call at once
```

## Settings Icon

Styles an SF Symbol as a rounded, colored icon tile, matching the look of a row icon in
the Settings app.

```swift
Image(systemName: "gear")
    .settingsIcon(.gray)
```

## Color Extensions

```swift
Color.allColors                              // every built-in SwiftUI system color, .red through .white
Color.vibrantColors                          // allColors, minus .black, .white, .gray, and .brown
Color.randomColor()                          // a random one from allColors
Color.randomColor(excludingNeutrals: true)   // a random one from vibrantColors
```

## Date Extensions

```swift
date.timeAgo               // TimeInterval since (or until) now
date.humanReadableTimeAgo  // a localized string, e.g. "5 min. ago", via RelativeDateTimeFormatter
```
