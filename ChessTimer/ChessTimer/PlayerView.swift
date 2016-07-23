//
//  PlayerView.swift
//  ChessTimer
//
//  Created by Mathias Quintero on 7/23/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import UIKit
import SnapKit

class PlayerView: UIView {
    
    let playerLabel = UILabel()
    
    override func drawRect(rect: CGRect) {
        addSubview(playerLabel)
        playerLabel.font = playerLabel.font.fontWithSize(100)
        playerLabel.snp_makeConstraints() { make in
            make.center.equalTo(self)
        }
    }
    
    func updateCounter(player: Player) {
        playerLabel.text = player.currentCounter
        backgroundColor = UIColor.clearColor()
        if player.counter < 60000 {
            playerLabel.textColor = UIColor.yellowColor()
        } else {
            playerLabel.textColor = UIColor.whiteColor()
        }
    }
    
    func animateChange(player: Player) {
        let scale: CGFloat = player.state == .Playing ? 1.0 : 0.5
        self.scale(scale)
    }
    
    private func scale(scale: CGFloat) {
        UIView.animateWithDuration(0.5) {
            self.playerLabel.transform = CGAffineTransformMakeScale(scale, scale)
        }
    }
    
    func end(won: Bool) {
        scale(1.0)
        UIView.animateWithDuration(0.5) {
            self.playerLabel.textColor = UIColor.whiteColor()
            self.playerLabel.text = won ? "Winner!" : "Loser"
            self.backgroundColor = won ? UIColor.greenColor() : UIColor.redColor()
        }
    }

}
