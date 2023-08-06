//
//  Bundle+AppInformation.swift
//  
//
//  Created by John Behnke on 8/5/23.
//

import Foundation

internal extension Bundle {
  var releaseVersionNumber: String {
    return infoDictionary?["CFBundleShortVersionString"] as? String ?? "20XX.YY"
  }
  var buildVersionNumber: String {
    return infoDictionary?["CFBundleVersion"] as? String ?? "-1"
  }
  var appName: String {
    infoDictionary?["CFBundleName"] as? String ?? "My App"
  }
}
