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

Footline can take 5 possible parameters:

1. `appName`
2. `releaseVersion`
3. `buildNumber`
4. `locationName`
5. `symbolName`

They are used in the following format:
```
appName releaseVersion (buildNumber)
Made in locationName with symbolName
```

By default, `appName`, `releaseVersion`, and `buildNumber` will be read from the app's Bundle, so they should refect those values based on the app you added Footline too.

*Note*: `symbolName` **NEEDS** to be a valid SFSymbol, otherwise nothing will render.

## Preview
![Footline_Demo](https://github.com/JohnBehnke/Footline/assets/5631869/b24e24ab-b97d-440a-a8d7-881e6515024a)
