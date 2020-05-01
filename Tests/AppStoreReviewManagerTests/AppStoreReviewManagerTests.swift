import XCTest
@testable import AppStoreReviewManager

final class AppStoreReviewManagerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        AppStoreReviewManager.requestReview { (success, version) in
            print("success: \(success)")
            print("version: \(version ?? "is nil")")
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
