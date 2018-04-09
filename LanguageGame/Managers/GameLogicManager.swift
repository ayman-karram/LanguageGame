//
//  GameLogicManager.swift
//  LanguageGame
//
//  Created by Ayman  on 08.04.18.
//  Copyright © 2018 Ayman . All rights reserved.
//

import Foundation

enum UserChoices : Int {
    case correct
    case wrong
    case noAnswer
}

struct userScores {
    var wrongs   = 0
    var correct  = 0
    var noAnswer = 0
    
    mutating func reset() {
        self.wrongs = 0
        self.correct = 0
        self.noAnswer = 0
    }
}

class GameLogicManager {
    
    //MARK:- Variables
    // Public
    static let sharedInstance = GameLogicManager()
    
    var sentencesList : [SentenceModel]?
    var currrentFirstLanguageSentences : String?
    var currrentSecondLanguageSentences : String?
    
    // read only for instances
    private(set) public var userScore =  userScores()
    private(set) public var totalRoundsCount = 5
    private(set) public var currentRoundIndex = 0

    // private
    private var currrentFirstLanguageSentencesIndex : Int?
    private var currrentSecondLanguageSentencesIndex : Int?
    
    private var firstLanguageSelectedIndexs : [Int] = []
    private var secondLanguageSelectedIndexs : [Int] = []
    
    
    //MARK:- Set up
    func setUpGame () {
        setRoundPlayParameters()
    }
    
    func resetGame() {
        userScore.reset()
        currentRoundIndex = 0
        currrentFirstLanguageSentencesIndex = 0
        currrentSecondLanguageSentencesIndex = 0
        firstLanguageSelectedIndexs.removeAll()
        secondLanguageSelectedIndexs.removeAll()
    }
    
    func prepareNextRound () {
        self.currentRoundIndex += 1
        self.setRoundPlayParameters()
    }
    
    private func setRoundPlayParameters () {
        let firstLangIndex = self.getRandamIndexFromFirstLanguageList()
        let secondLangIndex = self.getRandamIndexFromSecondLanguageList()
        self.currrentFirstLanguageSentences = self.sentencesList?[firstLangIndex].textEng
        self.currrentSecondLanguageSentences = self.sentencesList?[secondLangIndex].textSpa
        self.currrentFirstLanguageSentencesIndex  = firstLangIndex
        self.currrentSecondLanguageSentencesIndex = secondLangIndex
    }
    
    private func getRandamIndexFromFirstLanguageList () -> Int {
        
        var firstRandamIndex = arc4random_uniform(UInt32(self.totalRoundsCount + 1))
        
        // Make sure that this is new random index
        while (self.firstLanguageSelectedIndexs.contains(Int(firstRandamIndex))) {
            firstRandamIndex = arc4random_uniform(UInt32(self.totalRoundsCount + 1))
        }

        self.firstLanguageSelectedIndexs.append(Int(firstRandamIndex))
        return Int(firstRandamIndex)
    }
    
    
    private func getRandamIndexFromSecondLanguageList () -> Int {
        
        var secondRandamIndex = arc4random_uniform(UInt32(self.totalRoundsCount + 1))
        
        while (self.firstLanguageSelectedIndexs.contains(Int(secondRandamIndex))) {
            secondRandamIndex = arc4random_uniform(UInt32(self.totalRoundsCount + 1))
        }
        
        self.secondLanguageSelectedIndexs.append(Int(secondRandamIndex))
        return Int(secondRandamIndex)
    }
    
    //MARK:- user score
    private func increamentUserScore (choiceType : UserChoices) {
        
        switch choiceType {
        case .wrong:
            self.userScore.wrongs += 1
            break
        case .correct:
            self.userScore.correct += 1
            break
        case .noAnswer:
            self.userScore.noAnswer += 1
            break
        }
        
    }
    
    //MARK:- InterActions
    func userDidSelect (choiceType : UserChoices) -> UserChoices {
        let choiceResult = self.setUserScoreAccordingToHis(choiceType: choiceType)
        return choiceResult
    }
    
    
    //MAR:- Helpers
    private func setUserScoreAccordingToHis(choiceType :UserChoices ) -> UserChoices {
        
        let currentRoundIsCorrect = self.isCurrentSentencetranslationMatches()
        switch choiceType {
        case .wrong:
            if currentRoundIsCorrect {
                self.increamentUserScore(choiceType: .wrong)
                return .wrong
            }
            else {
                self.increamentUserScore(choiceType: .correct)
                return .correct
            }
        case .correct:
            if currentRoundIsCorrect {
                self.increamentUserScore(choiceType: .correct)
                return .correct
            }
            else {
                self.increamentUserScore(choiceType: .wrong)
                return .wrong
            }
        case .noAnswer:
            self.increamentUserScore(choiceType: .noAnswer)
            return .noAnswer
        }
    }
    
    private func isCurrentSentencetranslationMatches () -> Bool {
        if self.currrentFirstLanguageSentencesIndex == self.currrentSecondLanguageSentencesIndex {
            return true
        }
        else
        {
            return false
        }
    }
    
    func userFinishHisGame () -> Bool {
        if self.currentRoundIndex < self.totalRoundsCount - 1 {
            return false
        }
        else
        {
            return true
        }
    }
    
    func getCorrectAnswer () -> String {
        return (self.sentencesList?[self.currrentFirstLanguageSentencesIndex!].textSpa)!
    }
}
