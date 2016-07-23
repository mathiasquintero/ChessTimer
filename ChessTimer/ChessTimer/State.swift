//
//  State.swift
//  ChessTimer
//
//  Created by Mathias Quintero on 7/23/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
enum State {
    case Playing
    case Waiting
    
    func toggle() -> State {
        switch self {
        case .Playing:
            return .Waiting
        case .Waiting:
            return .Playing
        }
    }
}