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
    
    var playerSprite = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(80, 80))
    var currentStatus: CurrentPosition = CurrentPosition.Floor
    var animationFrames = Array<SKTexture>()
    var ligth: SKLightNode!
    var particule: SKEmitterNode?
    var isJumping: Bool = false
    
    func addLightPlayer() {
        self.ligth = SKLightNode()
        self.ligth.categoryBitMask = 1
        //self.ligth.falloff = 1
        self.ligth.ambientColor = UIColor.whiteColor()
        self.ligth.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.55)
        self.ligth.lightColor = UIColor.whiteColor().colorWithAlphaComponent(1)
        self.ligth.zPosition = 3
        self.ligth.categoryBitMask = 1
        self.ligth.position = CGPointZero
        self.playerSprite.addChild(self.ligth)
    }
    
    func initAnimationSprite() {
        for var index = 2; index < 22; index++ {
            self.animationFrames.append(PreloadData.getData("frame\(index)") as SKTexture)
        }
    }
    
    override init() {
        super.init()
        playerSprite.name = "player"
        playerSprite.position = CGPoint(x: UIScreen.mainScreen().bounds.size.width / 3, y: UIScreen.mainScreen().bounds.size.height / 2)
        playerSprite.zPosition = 2
        
        
//        var offsetX = playerSprite.frame.size.width * playerSprite.anchorPoint.x
//        var offsetY = playerSprite.frame.size.height * playerSprite.anchorPoint.y
//        
//        var path: CGMutablePathRef = CGPathCreateMutable();
//        
//        CGPathMoveToPoint(path, nil, 46 - offsetX, 84 - offsetY);
//        CGPathAddLineToPoint(path, nil, 37 - offsetX, 77 - offsetY);
//        CGPathAddLineToPoint(path, nil, 34 - offsetX, 68 - offsetY);
//        CGPathAddLineToPoint(path, nil, 30 - offsetX, 51 - offsetY);
//        CGPathAddLineToPoint(path, nil, 32 - offsetX, 18 - offsetY);
//        CGPathAddLineToPoint(path, nil, 37 - offsetX, 10 - offsetY);
//        CGPathAddLineToPoint(path, nil, 52 - offsetX, 8 - offsetY);
//        CGPathAddLineToPoint(path, nil, 64 - offsetX, 28 - offsetY);
//        CGPathAddLineToPoint(path, nil, 53 - offsetX, 75 - offsetY);
//        CGPathCloseSubpath(path);
//        
//        playerSprite.physicsBody = SKPhysicsBody(polygonFromPath: path)
        
        
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
        self.initAnimationSprite()
        self.runAnimation()
        
        let particulePath = NSBundle.mainBundle().pathForResource("Fire", ofType: "sks")
        self.particule = NSKeyedUnarchiver.unarchiveObjectWithFile(particulePath!) as? SKEmitterNode
        
        self.particule?.particlePosition = CGPointMake(5, 20)
        self.particule?.zPosition = 2
        self.particule?.position = CGPointZero
        self.playerSprite.addChild(particule!)
    }
    
    func positionFix() {
        if self.playerSprite.position.x != UIScreen.mainScreen().bounds.size.width / 3 {
            self.playerSprite.runAction(SKAction.moveToX(UIScreen.mainScreen().bounds.size.width / 3, duration: 0.5), completion: nil)
        }
    }
    
    func runAnimation() {
        let animation = SKAction.repeatActionForever(SKAction.animateWithTextures(self.animationFrames, timePerFrame: 0.04, resize: true, restore: false))
        self.playerSprite.runAction(animation)
    }
    
    func PlayerJump() {
        if self.isJumping == true {
            return Void()
        }
        self.isJumping = true
        playerSprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 250))
        self.playerSprite.runAction(SKAction.waitForDuration(0.70), completion: { () -> Void in
            self.isJumping = false
        })
    }
}