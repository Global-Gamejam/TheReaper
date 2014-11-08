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
    var node = PreloadData.makeSKSPriteNode("course1")
    var currentPosition: CurrentPosition = CurrentPosition.Floor
    var saveBody: SKPhysicsBody!
    var animationFrames = Array<SKTexture>()
    
    override init() {
        super.init()
        
        self.node.zPosition = 2
        self.node.position = CGPointMake(30, UIScreen.mainScreen().bounds.size.height / 3 + self.node.size.height / 2 + 5)
        self.node.name = "monster"
        self.node.shadowCastBitMask = 1
        println("init")
        self.initAnimationSprite()
        println("run")
        self.runAnimation()
    }
    
    func initAnimationSprite() {
        for var index = 1; index < 12; index++ {
            self.animationFrames.append(PreloadData.getData("course\(index)") as SKTexture)
        }
    }
    
    func runAnimation() {
        let animation = SKAction.repeatActionForever(SKAction.animateWithTextures(self.animationFrames, timePerFrame: 0.05, resize: true, restore: false))
        self.node.runAction(animation)
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
