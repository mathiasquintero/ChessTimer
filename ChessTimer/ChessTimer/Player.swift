//
//  Player.swift
//  ChessTimer
//
//  Created by Mathias Quintero on 7/23/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
class Player {
    
    var state: State
    var counter = 3000
    
    init() {
        state = .Waiting
    }
    
    var isChangeRelevant: Bool {
        get {
            return counter % 1000 == 0 && state == .Playing
        }
    }
    
    var lost: Bool {
        get {
            return counter == 0
        }
    }
    
    var currentCounter: String {
        get {
            let totalSeconds = counter / 1000
            let minutes = String(format: "%02d", totalSeconds / 60)
            let seconds = String(format: "%02d", totalSeconds % 60)
            return "\(minutes):\(seconds)"
        }
    }
    
    func toggle() {
        state = state.toggle()
    }
    
    func action() {
        if state == .Playing && counter > 0 {
            counter -= 1
        }
    }
    
    
}