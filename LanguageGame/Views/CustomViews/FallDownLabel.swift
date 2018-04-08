//
//  FallDownLabel.swift
//  LanguageGame
//
//  Created by Ayman  on 08.04.18.
//  Copyright © 2018 Ayman . All rights reserved.
//

import UIKit

class FallDownLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: MAINFONTNAME, size: 25)
        self.textColor = MAINTEXTGRAYCOLOR
        self.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
