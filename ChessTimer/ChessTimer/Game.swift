//
//  Game.swift
//  ChessTimer
//
//  Created by Mathias Quintero on 7/23/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
class Game {
    
    var playerOne: Player
    var playerTwo: Player
    let observer: GameObserver
    var timer: Timer?
    
    var isRunning: Bool {
        get {
            return timer != nil
        }
    }
    
    init(observer: GameObserver) {
        self.observer = observer
        playerOne = Player()
        playerTwo = Player()
        update()
    }
    
    func start() {
        playerOne = Player()
        playerTwo = Player()
        playerOne.toggle()
        updateIfChangeRelevant()
        observer.animateToggle(playerOne, playerTwo: playerTwo)
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(Game.action(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func action(_ sender: AnyObject? = nil) {
        playerOne.action()
        playerTwo.action()
        updateIfChangeRelevant()
        if playerOne.lost || playerTwo.lost {
            timer?.invalidate()
            timer = nil
            observer.gameEnded(!playerOne.lost, playerTwo: !playerTwo.lost)
        }
    }
    
    func toggle() {
        playerOne.toggle()
        playerTwo.toggle()
        observer.animateToggle(playerOne, playerTwo: playerTwo)
        update()
    }
    
    func updateIfChangeRelevant() {
        if playerOne.isChangeRelevant || playerTwo.isChangeRelevant {
            update()
        }
    }
    
    func update() {
         observer.updatePlayers(playerOne, playerTwo: playerTwo)
    }
    
}
