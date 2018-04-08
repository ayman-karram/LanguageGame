//
//  PlayViewController.swift
//  LanguageGame
//
//  Created by Ayman  on 08.04.18.
//  Copyright © 2018 Ayman . All rights reserved.
//

import Foundation
import UIKit
import TCProgressBar
import WCLShineButton
import SwiftMessages

class PlayViewController: UIViewController {
    
    //MARK:- Variables
    @IBOutlet weak var gameProgressBar: TCProgressBar!
    @IBOutlet weak var correctButton: WCLShineButton!
    @IBOutlet weak var wrongButton: WCLShineButton!
    @IBOutlet weak var sentenceTrackView: UIView!
    @IBOutlet weak var sentenceLabel: UILabel!
    
    // score view
    @IBOutlet weak var numberOfWrongScoreLabel: UILabel!
    @IBOutlet weak var numberOfNoAnswerScoreLabel: UILabel!
    @IBOutlet weak var numberOfCorrectScoreLabel: UILabel!
    
    var sentenceDropView :SentenceDropView?
    
    var playManager = GameLogicManager.sharedInstance
    var sentencesList : [SentenceModel]?
    
    var userChoiceAnswer = false
    
    //MARK:- View Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        initVariables()
        startPlay()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- SetUp Methods
    func setUpView () {
        var choicesButtonsParams = WCLShineParams()
        choicesButtonsParams.bigShineColor = UIColor(rgb: (225,147,0))
        choicesButtonsParams.smallShineColor = UIColor.green
        choicesButtonsParams.shineCount = 15
        choicesButtonsParams.animDuration = 2
        choicesButtonsParams.smallShineOffsetAngle = -5
        
        correctButton.params = choicesButtonsParams
        correctButton.image = .like
        wrongButton.params = choicesButtonsParams
        wrongButton.image = .like
        
        wrongButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    func initVariables() {
        self.playManager.sentencesList = self.sentencesList
        let sentenceDropViewFrame = CGRect(x: 0, y: 0, width: self.sentenceTrackView.frame.size.width, height: self.sentenceTrackView.frame.size.height)
        sentenceDropView = SentenceDropView(frame: sentenceDropViewFrame)
        self.sentenceTrackView.addSubview(sentenceDropView!)
    }
    
    //MARK:- Play Methods
    func startPlay () {
        playManager.setUpGame()
        setUpRound()
    }
    
    func setUpRound () {
        self.userChoiceAnswer = false
        self.enableChoicesButtons(enable: true)
        self.sentenceLabel.text = playManager.currrentFirstLanguageSentences
        self.sentenceDropView?.startDropLabelWith(text: playManager.currrentSecondLanguageSentences!, withCompletion: {
            if self.userChoiceAnswer == false {
                let _ = self.playManager.userDidSelect(choiceType: .noAnswer)
                self.updateUserScore()
            }
        })
    }
    
    func prepareForNextRound () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.correctButton.isSelected = false
            self.wrongButton.isSelected = false
            if self.playManager.userFinishHisGame() == false {
                self.playManager.prepareNextRound()
                self.setUpRound()
            }
            else
            {
                AlertManager.showFinishGameAlertWith(userScore: self.playManager.userScore, buttonTapHandler: { _ in
                    self.resetGame()
                    SwiftMessages.hide()
                    self.startPlay()
                })
            }
        }
    }
    func showAlertAccordingToUserAnswerWith (choiceType : UserChoices) {
        switch choiceType {
        case .correct:
            AlertManager.showYourAnswerCorrectAlert()
            break
        case .wrong:
            AlertManager.showYourAnswerIsWrongAlertWith(correctAnswer: playManager.getCorrectAnswer())
            break
        default:
            return
        }
    }
    
    func updateUserScore () {
        self.numberOfCorrectScoreLabel.text = String (self.playManager.userScore.correct)
        self.numberOfWrongScoreLabel.text = String (self.playManager.userScore.wrongs)
        self.numberOfNoAnswerScoreLabel.text = String (self.playManager.userScore.noAnswer)
        updateGameProgressBar()
        prepareForNextRound()
    }
    
    func updateGameProgressBar () {
        self.gameProgressBar.value = CGFloat(playManager.currentRoundIndex + 1) / CGFloat(playManager.totalRoundsCount)
    }
    
    func resetGame() {
        playManager.resetGame()
        self.userChoiceAnswer = false
        self.gameProgressBar.value = 0
        self.sentenceDropView?.resetLabelPosition()
        self.resetUserScoreView()
    }
    
    //MARK:- Helper
    func enableChoicesButtons(enable : Bool) {
        self.correctButton.isEnabled = enable
        self.wrongButton.isEnabled   = enable
    }
    
    func resetUserScoreView () {
        self.numberOfCorrectScoreLabel.text = "0"
        self.numberOfWrongScoreLabel.text = "0"
        self.numberOfNoAnswerScoreLabel.text = "0"
    }
    
    //MARK:- IBAction Methods
    @IBAction func correctButtonClicked(_ sender: Any) {
        self.userChoiceAnswer = true
        self.sentenceDropView?.resetLabelPosition()
        let result = self.playManager.userDidSelect(choiceType: .correct)
        self.showAlertAccordingToUserAnswerWith(choiceType: result)
        updateUserScore()
        self.enableChoicesButtons(enable: false)
    }
    
    @IBAction func wrongButtonClicked(_ sender: Any) {
        self.userChoiceAnswer = true
        self.sentenceDropView?.resetLabelPosition()
        let result = self.playManager.userDidSelect(choiceType: .wrong)
        self.showAlertAccordingToUserAnswerWith(choiceType: result)
        updateUserScore()
        self.enableChoicesButtons(enable: false)
    }
}

