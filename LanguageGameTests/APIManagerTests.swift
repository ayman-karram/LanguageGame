//
//  APIManagerTests.swift
//  LanguageGameTests
//
//  Created by Ayman  on 09.04.18.
//  Copyright © 2018 Ayman . All rights reserved.
//

import XCTest
import Alamofire
@testable import LanguageGame

class APIManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetSentencesAPI () {
        APIManager.getsentencesList(completionHandler: { response in
            let error = response.error
            XCTAssertNil(error, "Expect that API not respond with error")
        })
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
