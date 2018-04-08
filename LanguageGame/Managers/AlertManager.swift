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
}
