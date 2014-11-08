//
//  Player.swift
//  GameJam
//
//  Created by Julien on 07/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import Foundation
import SpriteKit

class Player: NSObject {
    
    var playerSprite = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(30, 30))
    var currentStatus: CurrentPosition = CurrentPosition.Floor
    var ligth: SKLightNode!
    
    func addLightPlayer() {
        self.ligth = SKLightNode()
        self.ligth.categoryBitMask = 1
        self.ligth.falloff = 1
        self.ligth.ambientColor = UIColor.whiteColor()
        self.ligth.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        self.ligth.lightColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        self.ligth.zPosition = 3
        self.ligth.categoryBitMask = 1
        self.ligth.position = CGPointZero
        self.playerSprite.addChild(self.ligth)
    }
    
    override init() {
        super.init()
        playerSprite.name = "player"
        playerSprite.position = CGPoint(x: UIScreen.mainScreen().bounds.size.width / 3, y: UIScreen.mainScreen().bounds.size.height / 2)
        playerSprite.zPosition = 2
        playerSprite.physicsBody = SKPhysicsBody(rectangleOfSize: self.playerSprite.size)
        playerSprite.physicsBody?.dynamic = true
        playerSprite.physicsBody?.affectedByGravity = true
        playerSprite.physicsBody?.allowsRotation = false
        playerSprite.physicsBody?.usesPreciseCollisionDetection = true
        
        playerSprite.physicsBody?.categoryBitMask = CollisionCategory.Player.rawValue
        playerSprite.physicsBody?.collisionBitMask = CollisionCategory.Floor.rawValue | CollisionCategory.Plateform.rawValue |
            CollisionCategory.Down.rawValue | CollisionCategory.ItemNone.rawValue
        playerSprite.physicsBody?.contactTestBitMask = CollisionCategory.Floor.rawValue | CollisionCategory.Plateform.rawValue | CollisionCategory.Down.rawValue
        
        self.addLightPlayer()
    }
    
    func positionFix() {
        if self.playerSprite.position.x != UIScreen.mainScreen().bounds.size.width / 3 {
            self.playerSprite.runAction(SKAction.moveToX(UIScreen.mainScreen().bounds.size.width / 3, duration: 0.5), completion: nil)
//            self.ligth.runAction(SKAction.moveToX(UIScreen.mainScreen().bounds.size.width / 3, duration: 0.5), completion: nil)
        }
    }
    
    func PlayerJump() {
        playerSprite.physicsBody?.velocity = CGVectorMake(0, 0)
        playerSprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 24))
    }
}