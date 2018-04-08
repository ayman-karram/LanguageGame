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

class PlayViewController: UIViewController {
    
    //MARK:- Variables
    @IBOutlet weak var gameProgressBar: TCProgressBar!
    @IBOutlet weak var correctButton: WCLShineButton!
    @IBOutlet weak var wrongButton: WCLShineButton!
    @IBOutlet weak var sentenceTrackView: UIView!
    
    var sentenceDropView :SentenceDropView?
    
    var playManager = GameLogicManager.sharedInstance
    var sentencesList : [SentenceModel]?
    
    //MARK:- View Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        initVariables()
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
        gameProgressBar.value = 0.5
    }
    
    func initVariables() {
        self.playManager.sentencesList = self.sentencesList
        let sentenceDropViewFrame = CGRect(x: 0, y: 0, width: self.sentenceTrackView.frame.size.width, height: self.sentenceTrackView.frame.size.height)
        sentenceDropView = SentenceDropView(frame: sentenceDropViewFrame)
        self.sentenceTrackView.addSubview(sentenceDropView!)
        sentenceDropView?.startDropLabelWith(text: "Testing", with: {
            
        })
    }
    
    //MARK:- IBAction Methods
    @IBAction func correctButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func wrongButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func dissmissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

