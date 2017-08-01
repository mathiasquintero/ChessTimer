//
//  ViewController.swift
//  ChessTimer
//
//  Created by Mathias Quintero on 7/23/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

class GameViewController: UIViewController {
    
    let playerOneView = PlayerView()
    let playerTwoView = PlayerView()
    var game: Game?

    override func viewDidLoad() {
        game = Game(observer: self)
        super.viewDidLoad()
        setUpInterface()
    }
    
    func setUpInterface() {
        let sepatatorView = UIView()
        sepatatorView.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.black
        
        view.addSubview(playerTwoView)
        view.addSubview(playerOneView)
        view.addSubview(sepatatorView)
        
        sepatatorView.snp_makeConstraints() { make in
            make.center.equalTo(view)
            make.left.right.equalTo(view)
            make.height.equalTo(0.5)
        }
        
        playerOneView.snp_makeConstraints() { make in
            make.bottom.left.right.equalTo(view)
            make.top.equalTo(sepatatorView.snp_bottom)
        }
        
        playerTwoView.snp_makeConstraints() { make in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(sepatatorView.snp_top)
        }
        
        playerTwoView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0.0, 0.0, 1.0)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GameViewController.toggle(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func toggle(_ sender: AnyObject? = nil) {
        if game?.isRunning ?? false {
           game?.toggle()
        } else {
            game?.start()
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

}

extension GameViewController: GameObserver {
    
    func updatePlayers(_ playerOne: Player, playerTwo: Player) {
        playerOneView.updateCounter(playerOne)
        playerTwoView.updateCounter(playerTwo)
    }
    
    func animateToggle(_ playerOne: Player, playerTwo: Player) {
        playerOneView.animateChange(playerOne)
        playerTwoView.animateChange(playerTwo)
    }
    
    func gameEnded(_ playerOne: Bool, playerTwo: Bool) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        playerOneView.end(playerOne)
        playerTwoView.end(playerTwo)
    }
    
}

