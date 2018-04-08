//
//  SentenceDropView.swift
//  LanguageGame
//
//  Created by Ayman  on 08.04.18.
//  Copyright © 2018 Ayman . All rights reserved.
//

import Foundation
import UIKit

class SentenceDropView: UIView {
    
    private var fallDownLabel : FallDownLabel?
    private let fallDownLabelHeight : CGFloat = 60
    private var fallDownLabelStartFrame : CGRect?
    private var fallDownLabelEndFrame : CGRect?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFallDownLabelFrame(currentViewFrame: frame)
    }
    
    func initFallDownLabelFrame (currentViewFrame : CGRect) {
        var frame = CGRect(x: 0, y:0 , width: self.frame.size.width, height: fallDownLabelHeight)
        self.fallDownLabelStartFrame = frame
        fallDownLabel = FallDownLabel(frame: self.fallDownLabelStartFrame!)
        self.addSubview(fallDownLabel!)
        fallDownLabel?.alpha = 0
        let endYPosition = self.frame.height - self.fallDownLabelHeight
        frame.origin.y = endYPosition
        self.fallDownLabelEndFrame = frame
    }

    
    func startDropLabelWith(text :String, withCompletion: @escaping () -> ()) {
        DispatchQueue.main.async {
        self.fallDownLabel?.text = text
        self.fallDownLabel?.alpha = 0.5
        UIView.animate(withDuration: 5, animations: {
            self.dropLabelDown()
        }, completion: { done in
            UIView.animate(withDuration: 1, animations: {
                self.fallDownLabel?.alpha = 0
            }, completion: { done in
                self.resetLabelPosition()
                withCompletion()
            })
        })
        }
    }
    
    func dropLabelDown() {
        self.fallDownLabel?.alpha = 1
        self.fallDownLabel?.frame = self.fallDownLabelEndFrame!
    }
    
    func resetLabelPosition() {
        DispatchQueue.main.async {
        self.fallDownLabel?.frame = self.fallDownLabelStartFrame!
        self.fallDownLabel?.alpha = 0
        self.fallDownLabel?.layer.removeAllAnimations()
        }
    }
}
