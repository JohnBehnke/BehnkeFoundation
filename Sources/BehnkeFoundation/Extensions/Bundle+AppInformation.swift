//
//  Bundle+AppInformation.swift
//
//
//  Created by John Behnke on 8/5/23.
//

import Foundation

extension Bundle {
    /// The app's marketing version (`CFBundleShortVersionString`), e.g. `"1.2.0"`.
    ///
    /// Falls back to `"20XX.YY"` if the bundle has no version set.
    public var releaseVersionNumber: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? "20XX.YY"
    }

    /// The app's build number (`CFBundleVersion`), e.g. `"42"`.
    ///
    /// Falls back to `"-1"` if the bundle has no build number set.
    public var buildVersionNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? "-1"
    }

    /// The app's display name (`CFBundleName`).
    ///
    /// Falls back to `"My App"` if the bundle has no name set.
    public var appName: String {
        infoDictionary?["CFBundleName"] as? String ?? "My App"
    }
}
