//
//  GenerateMonster.swift
//  GameJam
//
//  Created by Remi Robert on 08/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

extension GameScene {
    func addMonster() {
        if rand() % 2 != 0 {
            return Void()
        }
        
        let sprite = PreloadData.makeSKSPriteNode("monster4")
        
        sprite.name = "monsterAdd"
        sprite.zPosition = 2
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size)

        let positionMonster = CGFloat(self.player.currentStatus.hashValue) *
            CGFloat((UIScreen.mainScreen().bounds.size.height / 3)) +
            (sprite.size.height / 2 + 5)
        sprite.position = CGPointMake(self.size.width + sprite.size.width / 2, positionMonster)
        
        self.addChild(sprite)
    }
}
