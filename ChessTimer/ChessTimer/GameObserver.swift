//
//  GameObserver.swift
//  ChessTimer
//
//  Created by Mathias Quintero on 7/23/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
protocol GameObserver {
    func updatePlayers(playerOne: Player, playerTwo: Player)
    func animateToggle(playerOne: Player, playerTwo: Player)
    func gameEnded(playerOne: Bool, playerTwo: Bool)
}