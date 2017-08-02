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
    private var internalRemaining: TimeInterval = 5.0 * 60.0
    private var lastStateChange: Date
    
    var remaining: TimeInterval {
        guard case .playing = state else {
            return max(0, internalRemaining)
        }
        return max(0, internalRemaining - Date().timeIntervalSince(lastStateChange))
    }
    
    init() {
        state = .waiting
        lastStateChange = Date()
    }
    
    var isChangeRelevant: Bool {
        return (remaining - Double(Int(remaining))) < 0.1 && state == .playing
    }
    
    var lost: Bool {
        return remaining == 0
    }
    
    var currentCounter: String {
        let minutes = String(format: "%02d", Int(remaining / 60.0))
        let seconds = String(format: "%02d", Int(remaining) % 60)
        return "\(minutes):\(seconds)"
    }
    
    func toggle() {
        internalRemaining = remaining
        lastStateChange = Date()
        state = state.toggle()
    }
    
    
}
