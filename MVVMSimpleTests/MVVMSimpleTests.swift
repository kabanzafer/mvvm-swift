//
//  MVVMSimpleTests.swift
//  MVVMSimpleTests
//
//  Created by Zafer Kaban on 10/11/18.
//  Copyright © 2018 Zafer Kaban. All rights reserved.
//

import XCTest
@testable import MVVMSimple

class MVVMSimpleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchMovie() {
        let expectation = self.expectation(description: "Test Search Movie")
        OMDBManager.shared.searchForTitle("Terminator") { (resultArray) in
            XCTAssert(resultArray!.count > 0)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5.0)
    }
    
}
