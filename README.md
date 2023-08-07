# Footline
A SwiftUI View for adding a little fun and interactive footline/footer to your app

## Contents

- [Add the Package](#package)
- [Basic Usage](#basic-usage)
- [Preview](#preview)

## Package

### For Xcode Projects

File > Swift Packages > Add Package Dependency: https://github.com/JohnBehnke/Footline

### For Swift Packages

Add a dependency in your your `Package.swift`

```swift
.package(url: "https://github.com/JohnBehnke/Footline.git", from: "1.0.0"),
```

## Basic Usage

Just import Footline and add the Footline view whereever you please.

```swift
import Footline
...
Footline()
```

Footline can take 2 possible parameters:

1. `locationName`
2. `symbolName`

They are used in the following format:
```
appName releaseVersion (buildNumber)
Made in locationName with symbolName
```

*Note*: `symbolName` **NEEDS** to be a valid SFSymbol, otherwise nothing will render.

If you want to add some kind of Gesture Recognizer to the Footline, you'll need to use a `simultaneousGesture`

Example:

```swift
import Footline
...
Footline()
.simultaneousGesture(
  TapGesture().onEnded {
      print("Footline Tap")
  }
)
```

## Preview
![Footline_Demo](https://github.com/JohnBehnke/Footline/assets/5631869/b24e24ab-b97d-440a-a8d7-881e6515024a)
