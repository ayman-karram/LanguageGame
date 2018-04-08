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
        startPlayButtton.stopAnimation(animationStyle: .expand, completion: {
            let playNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "playNavigationController") as! UINavigationController
            playNavigationController.setNavigationBarHidden(true, animated: false)
            self.present(playNavigationController, animated: true, completion: nil)
        })
        self.startPlayButtton.stopAnimation()
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
