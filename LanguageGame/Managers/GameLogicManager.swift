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
}

class GameLogicManager {
    
    //MARK:- Variables
    // Public
    static let sharedInstance = GameLogicManager()
    
    var sentencesList : [SentenceModel]?
    var currrentFirstLanguageSentences : String?
    var currrentSecondLanguageSentences : String?
    private(set) public var userScore =  userScores() // read only for instances
    
    // private
    private  var totalRoundsCount = 5
    private  var currentRoundIndex = 0

    private var firstLanguageSentencesList : [String]?
    private var secondLanguageSentencesList : [String]?
    private var currrentFirstLanguageSentencesIndex : Int?
    private var currrentSecondLanguageSentencesIndex : Int?
    
    private var firstLanguageSelectedIndexs : [Int]?
    private var secondLanguageSelectedIndexs : [Int]?


    //MARK:- Set up
    func setUpGame () {
        spliteSentencesList()
        setCurrentPlayParameters()
    }
    
    private func spliteSentencesList () {
        guard let sentencesList = self.sentencesList else {
            return
        }
        for sentence in sentencesList {
            self.firstLanguageSentencesList?.append(sentence.textEng)
            self.secondLanguageSentencesList?.append(sentence.textSpa)
        }
    }
    
    private func setCurrentPlayParameters () {
        let firstLangIndex = self.getRandamIndexFromFirstLanguageList()
        let secondLangIndex = self.getRandamIndexFromSecondLanguageList()
        self.currrentFirstLanguageSentences = self.firstLanguageSentencesList?[firstLangIndex]
        self.currrentSecondLanguageSentences = self.firstLanguageSentencesList?[secondLangIndex]
        self.currrentFirstLanguageSentencesIndex  = firstLangIndex
        self.currrentSecondLanguageSentencesIndex = secondLangIndex
    }
    
    private func getRandamIndexFromFirstLanguageList () -> Int {
        
        let firstRandamIndex = arc4random_uniform(UInt32(self.totalRoundsCount))
        
        // Make sure that this is new random index
        while (self.firstLanguageSelectedIndexs?.contains(Int(firstRandamIndex)))! {
            return self.getRandamIndexFromFirstLanguageList()
        }
        self.firstLanguageSelectedIndexs?.append(Int(firstRandamIndex))
        return Int(firstRandamIndex)
    }
    
    private func getRandamIndexFromSecondLanguageList () -> Int {
        
        let secondRandamIndex = arc4random_uniform(UInt32(self.totalRoundsCount))
        
        // Make sure that this is new random index
        while (self.firstLanguageSelectedIndexs?.contains(Int(secondRandamIndex)))! {
            return self.getRandamIndexFromSecondLanguageList()
        }
        self.secondLanguageSelectedIndexs?.append(Int(secondRandamIndex))
        return Int(secondRandamIndex)
    }
    
    //MARK:- user score
    func increamentUserScore (choiceType : UserChoices) {
        
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
        self.currentRoundIndex += 1
        return choiceResult
    }
    
    
    //MAR:- Helpers
    func setUserScoreAccordingToHis(choiceType :UserChoices ) -> UserChoices {
        
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
    
    func isCurrentSentencetranslationMatches () -> Bool {
        if self.currrentFirstLanguageSentencesIndex == self.currrentSecondLanguageSentencesIndex {
            return true
        }
        else
        {
            return false
        }
    }
    
    func userCanPlayNextRound () -> Bool {
        if self.currentRoundIndex < self.totalRoundsCount {
            return true
        }
        else
        {
            return false
        }
    }
}
