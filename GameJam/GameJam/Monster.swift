//
//  Monster.swift
//  GameJam
//
//  Created by Remi Robert on 08/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

class Monster: NSObject {
    var node = SKSpriteNode(color: UIColor.grayColor(), size: CGSizeMake(60, 60))
    var currentPosition: CurrentPosition = CurrentPosition.Floor
    var saveBody: SKPhysicsBody!
    
    override init() {
        super.init()
        
        self.node.zPosition = 2
        self.node.position = CGPointMake(30, UIScreen.mainScreen().bounds.size.height / 3 + self.node.size.height / 2 + 5)
        self.node.name = "monster"
        self.node.shadowCastBitMask = 1
    }
    
    func updatePosition(player: Player) {
        let positionPlayer = CGFloat(player.currentStatus.hashValue) *
            CGFloat((UIScreen.mainScreen().bounds.size.height / 3)) +
            (self.node.size.height / 2 + 5)
        
        if self.currentPosition != player.currentStatus {
            self.currentPosition = player.currentStatus
            self.node.runAction(SKAction.moveToY(positionPlayer, duration: 1), completion: { () -> Void in
            })
        }
        return Void()
    }
}
