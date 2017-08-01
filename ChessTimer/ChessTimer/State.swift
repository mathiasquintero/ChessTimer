//
//  State.swift
//  ChessTimer
//
//  Created by Mathias Quintero on 7/23/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
enum State {
    case playing
    case waiting
    
    func toggle() -> State {
        switch self {
        case .playing:
            return .waiting
        case .waiting:
            return .playing
        }
    }
}
