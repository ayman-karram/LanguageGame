//
//  AlertManager.swift
//  LanguageGame
//
//  Created by Ayman  on 08.04.18.
//  Copyright © 2018 Ayman . All rights reserved.
//

import Foundation
import SwiftMessages

class AlertManager {
    
    class func showNoInterNetAlert () {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.error)
        warning.configureDropShadow()
        let iconText = ""
        warning.configureContent(title: "Warning", body: "Kindly check your internet connection.", iconText: iconText)
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        SwiftMessages.show(config: warningConfig, view: warning)
        
    }
    
    class func showYourAnswerCorrectAlert() {
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.success)
        success.configureDropShadow()
        let iconText = ""
        success.configureContent(title: "Good Job!", body: "Correct!.", iconText: iconText)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .center
        successConfig.duration = .seconds(seconds: TimeInterval(ALERTMESSAGEDURATION))
        successConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        SwiftMessages.show(config: successConfig, view: success)
    }
    
    class func showYourAnswerIsWrongAlertWith (correctAnswer : String) {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.error)
        warning.configureDropShadow()
        let iconText = ""
        warning.configureContent(title: "Sorry!", body: "Your answer is not correct the correct answer is \(correctAnswer)!", iconText: iconText)
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationStyle = .center
        warningConfig.duration = .seconds(seconds: TimeInterval(ALERTMESSAGEDURATION))
        warningConfig.presentationContext = .window(windowLevel: UIWindowLevelAlert)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
    
    class func showFinishGameAlertWith (userScore : userScores, buttonTapHandler: ((_ button: UIButton) -> Void)?) {
        let messageView: MessageView = MessageView.viewFromNib(layout: .centeredView)
        messageView.configureBackgroundView(width: 250)
        let mainMessage = "You Finsish the Game with score \n "
        let message =  mainMessage + "Correct: \(userScore.correct) \n Wrong: \(userScore.wrongs) \n No Answer: \(userScore.noAnswer)\n"
        messageView.configureContent(title: "Hey There!", body: message, iconImage: nil, iconText: "🦄", buttonImage: nil, buttonTitle: "Play again") { completion in
            buttonTapHandler!(completion)
        }
        messageView.backgroundView.backgroundColor = UIColor.init(white: 0.97, alpha: 1)
        messageView.backgroundView.layer.cornerRadius = 10
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.duration = .forever
        config.dimMode = .blur(style: .dark, alpha: 1, interactive: true)
        config.presentationContext  = .window(windowLevel: UIWindowLevelStatusBar)
        SwiftMessages.show(config: config, view: messageView)
    }
}
