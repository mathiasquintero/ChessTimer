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
    
    override func draw(_ rect: CGRect) {
        addSubview(playerLabel)
        playerLabel.font = playerLabel.font.withSize(100).monospacedDigitFont
        playerLabel.snp_makeConstraints() { make in
            make.center.equalTo(self)
        }
    }
    
    func updateCounter(for player: Player) {
        playerLabel.text = player.currentCounter
        backgroundColor = UIColor.clear
        if player.remaining < 60.0 {
            playerLabel.textColor = UIColor.yellow
        } else {
            playerLabel.textColor = UIColor.white
        }
    }
    
    func animateChange(_ player: Player) {
        let scale: CGFloat = player.state == .playing ? 1.0 : 0.5
        self.scale(to: scale)
    }
    
    fileprivate func scale(to scale: CGFloat) {
        UIView.animate(withDuration: 0.5, animations: {
            self.playerLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) 
    }
    
    func end(_ won: Bool) {
        scale(to: 1.0)
        UIView.animate(withDuration: 0.5, animations: {
            self.playerLabel.textColor = UIColor.white
            self.playerLabel.text = won ? "Winner!" : "Loser"
            self.backgroundColor = won ? UIColor.green : UIColor.red
        }) 
    }

}

extension UIFontDescriptor {
    
    var monospacedDigitFontDescriptor: UIFontDescriptor {
        let fontDescriptorFeatureSettings = [
            [
                UIFontFeatureTypeIdentifierKey: kNumberSpacingType,
                UIFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector,
            ]
        ]
        let fontDescriptorAttributes = [UIFontDescriptorFeatureSettingsAttribute: fontDescriptorFeatureSettings]
        let fontDescriptor = self.addingAttributes(fontDescriptorAttributes)
        return fontDescriptor
    }
    
}

extension UIFont {
    
    var monospacedDigitFont: UIFont {
        let oldFontDescriptor = fontDescriptor
        let newFontDescriptor = oldFontDescriptor.monospacedDigitFontDescriptor
        return UIFont(descriptor: newFontDescriptor, size: 0)
    }
    
}
