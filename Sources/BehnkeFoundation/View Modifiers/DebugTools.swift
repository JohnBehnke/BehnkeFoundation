//
//  DebugTools.swift
//
//
//  Created by John Behnke on 8/27/26.
//

#if DEBUG
/// A global switch for BehnkeFoundation's debug-only view tools (`debugFrame`, `debugTrace`).
///
/// Only exists in `DEBUG` builds. Flip `isEnabled` off to silence every `.debugFrame()`
/// and `.debugTrace()` call in the app at once, without removing any of them from source —
/// handy for demoing a debug build cleanly, then flipping it back on afterward.
///
/// ```swift
/// DebugTools.isEnabled = false
/// ```
@MainActor
public enum DebugTools {
    /// Whether `.debugFrame()` and `.debugTrace()` do anything. Defaults to `true`.
    public static var isEnabled = true
}
#endif
