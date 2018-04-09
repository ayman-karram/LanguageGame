//
//  GameLogicManagerTests.swift
//  LanguageGameTests
//
//  Created by Ayman  on 09.04.18.
//  Copyright © 2018 Ayman . All rights reserved.
//

import XCTest
@testable import LanguageGame
class GameLogicManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTheInitiationOfSingltonObject () {
        let gameLogicSingltonManager = GameLogicManager.sharedInstance
        gameLogicSingltonManager.currrentFirstLanguageSentences = "School"
        
        let secondManager = GameLogicManager.sharedInstance
        XCTAssertEqual(secondManager.currrentFirstLanguageSentences, "School", "Expect that secondManager.currrentFirstLanguageSentences still School")
    }
    
    func testPassingsentencesListToGameLogicManagerObject () {
        APIManager.getsentencesList(completionHandler: { response in
            let error = response.error
            XCTAssertNil(error, "Expect that API not respond with error")
            GameLogicManager.sharedInstance.sentencesList = response.result.value
            XCTAssertNotNil(GameLogicManager.sharedInstance.sentencesList, "Expect that GameLogicManager.sharedInstance.sentencesList not nil")
        })
    }
    
    func testResetGame () {
        let gameLogicSingltonManager = GameLogicManager.sharedInstance
        gameLogicSingltonManager.setUpGame()
        gameLogicSingltonManager.resetGame()
        let currentRoundIndex = gameLogicSingltonManager.currentRoundIndex
        XCTAssertTrue(currentRoundIndex == 0, "Expect that currentRoundIndex = 0 after reset")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
