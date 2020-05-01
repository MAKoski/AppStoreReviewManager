# AppStoreReviewManager

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/MAKoski/AppStoreReviewManager/blob/master/LICENSE)
[![Swift 5](https://img.shields.io/badge/language-Swift-blue.svg)](https://swift.org)
[![macOS](https://img.shields.io/badge/OS-macOS-orange.svg)](https://developer.apple.com/macos/)
[![iOS](https://img.shields.io/badge/OS-iOS-orange.svg)](https://developer.apple.com/ios/)

AppStoreReviewManager is a simple utility to prompt the users of your iOS or macOS apps to submit a review.

This utility by default will not immediatly call for an app review, instead it keeps track until a minimum threshold of calls is hit before prompting the user for a review. It will also only request one review for each app version that is released.

Example:
Version 1.0 - The user will be prompted the 5th time they launch the app to give a start rating and write a review. Launches 6+, they will not be prompted again.
App is updated to version 1.0.1 - The user will be prompted after the 5th launch of this new version to review

# How to use
Basic (no completion block, will prompt after the app calls this 5 times)
```swift
AppStoreReviewManager.requestReview()
```

If you want to have a different minimum threshold
```swift
AppStoreReviewManager.requestReview(minimumActionCount: 5)
```

A custom completion block (if you're like me and want to report some analytics on this event)
```swift
AppStoreReviewManager.requestReview(completion: { (success, appVersion?) in
// success: Bool - If the user was prompted for a review
// appVersion: String? - What version of the app the user was prompted for
}
```

All of the goodies, if you want to customize the minimum threshold and want a callback
```swift
AppStoreReviewManager.requestReview(minimumActionCount: 0) { (success, appVersion?) in
// success: Bool - If the user was prompted for a review
// appVersion: String? - What version of the app the user was prompted for
}
```

## Recommended placement
Recommended placement is in the AppDelegate.swift file in the `didFinishLaunchingWithOptions` function. That way the user isn't spammed and it's guaranteed to check once per app launch.
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
/* ... other startup stuff */
AppStoreReviewManager.requestReview()
}
```
