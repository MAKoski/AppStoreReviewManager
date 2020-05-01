import Foundation
import StoreKit

public enum AppStoreReviewManager {
    private static let actionCountKey = "AppStoreReviewManager_actionCount"
    private static let lastReviewedAppVersionKey = "AppStoreReviewManager_lastReviewedAppVersion"
    private static let lastAppVersionCheckedKey = "AppStoreReviewManager_lastAppVersionChecked"

    public static func requestReview() {
        self.requestReview(minimumActionCount: 5, completion: nil)
    }

    public static func requestReview(minimumActionCount: Int) {
        self.requestReview(minimumActionCount: minimumActionCount, completion: nil)
    }

    public static func requestReview(completion: ((_ success: Bool, _ version: String?) -> Void)?) {
        self.requestReview(minimumActionCount: 5, completion: completion)
    }

    public static func requestReview(minimumActionCount: Int, completion: ((_ success: Bool, _ version: String?) -> Void)?) {
        guard let currentAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            completion?(false, nil)
            return
        }

        // Retrieve previously saved action count
        var savedActionCount = UserDefaults.standard.integer(forKey: actionCountKey)
        savedActionCount += 1

        // Ensure current version is saved and action count is correct for each version of the app
        let lastVersionChecked = UserDefaults.standard.string(forKey: lastAppVersionCheckedKey)
        if lastVersionChecked != currentAppVersion {
            savedActionCount = 1
            UserDefaults.standard.set(currentAppVersion, forKey: lastAppVersionCheckedKey)
        }

        UserDefaults.standard.set(savedActionCount, forKey: actionCountKey)

        if savedActionCount % minimumActionCount != 0 {
            // Don't continue if savedActionCount is not at or past the minimum
            completion?(false, currentAppVersion)
            return
        }

        let lastVersionReviewed = UserDefaults.standard.string(forKey: lastReviewedAppVersionKey)

        if currentAppVersion == lastVersionReviewed {
            // Don't ask to review this version again if already asked
            completion?(false, currentAppVersion)
            return
        }

        SKStoreReviewController.requestReview()

        UserDefaults.standard.set(0, forKey: actionCountKey)
        UserDefaults.standard.set(currentAppVersion, forKey: lastReviewedAppVersionKey)

        completion?(true, currentAppVersion)
    }
}
