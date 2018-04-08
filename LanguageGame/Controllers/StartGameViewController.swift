//
//  StartGameViewController.swift
//  LanguageGame
//
//  Created by Ayman  on 08.04.18.
//  Copyright © 2018 Ayman . All rights reserved.
//

import Foundation
import UIKit
import TransitionButton

class StartGameViewController: UIViewController {
    
    //MARK:- Variables
    @IBOutlet weak var startPlayButtton: TransitionButton!
    let reachability = Reachability()
    var sentencesList : [SentenceModel]?

    //MARK:- View Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- SetUp Methods
    func setUpUIView () {
        startPlayButtton.cornerRadius = 25
    }
    
    //MARK:- Web servies Methods
    func getSentencesListArray () {
        if (ReachabilityManager.sharedInstance.isRechable()) {
            APIManager.getsentencesList(completionHandler: { response in
                self.sentencesList = response.result.value
                self.handelGetSentencesSuccess()
            })
        }
        else
        {
            self.handelGetSentencesFail()
        }
    }
    
    //MAR:- Helper Methods
    func handelGetSentencesSuccess () {
        self.startPlayButtton.stopAnimation()
        startPlayButtton.stopAnimation(animationStyle: .expand, completion: {
            
            guard let sentencesList = self.sentencesList else {
                return
            }

            let playViewController = self.storyboard?.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
            playViewController.sentencesList = sentencesList
            self.present(playViewController, animated: true, completion: nil)
        })
    }
    func handelGetSentencesFail () {
        startPlayButtton.stopAnimation()
        AlertManager.showNoInterNetAlert()
    }
    
    //MARK:- IBAction Methods
    @IBAction func startButtonClicked(_ sender: Any) {
        startPlayButtton.startAnimation()
        getSentencesListArray()
    }
}
