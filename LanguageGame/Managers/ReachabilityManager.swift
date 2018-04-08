//
//  ReachabilityManager.swift
//  LanguageGame
//
//  Created by Ayman  on 08.04.18.
//  Copyright © 2018 Ayman . All rights reserved.
//

import Foundation
class ReachabilityManager {
    
    static  let sharedInstance = ReachabilityManager()
    private let reachability = Reachability()
    
    private init() {
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func isRechable () -> Bool {
        return (self.reachability!.connection != Reachability.Connection.none)
    }
}
