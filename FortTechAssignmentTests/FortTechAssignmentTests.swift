//
//  FortTechAssignmentTests.swift
//  FortTechAssignmentTests
//
//  Created by Priyanka Kumari on 22/09/23.
//

import XCTest
@testable import FortTechAssignment

final class FortTechAssignmentTests: XCTestCase {
    var viewModel: HomeViewModel?
    
    override func setUpWithError() throws {
        viewModel = HomeViewModel()
    }

    func test01_fetchHomeData() {
        let expectation = self.expectation(description: "Load Feeds")
        viewModel?.fetchHomeData(completion: { data in
            XCTAssertNotNil(data, "Home data model should not be nil")
            if !data.isEmpty {
                XCTAssertNotNil(data, "data should not be nil")
                self.viewModel?.homeData.append(contentsOf: data)
            }
            expectation.fulfill()
        })
        waitForRequestDefaultTimeout()
    }
    
    func waitForRequestDefaultTimeout() {
        self.waitForExpectations(timeout: 200, handler: { (error) -> Void in
            if error != nil {
                XCTFail("Could not perform operation (Timed out) ~ ERR: " + (error?.localizedDescription)!)
            }
        })
    }

}
