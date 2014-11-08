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
    
    //let textureAtlas = SKTextureAtlas(named:"perso.atlas")
    var playerSprite = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(30, 30))
    //var spriteArray = Array<SKTexture>()
    var currentStatus: CurrentPosition = CurrentPosition.Floor
    
    
    override init() {
        super.init()
        playerSprite.name = "player"
        playerSprite.position = CGPoint(x: UIScreen.mainScreen().bounds.size.width / 3, y: UIScreen.mainScreen().bounds.size.height / 2)
        playerSprite.zPosition = 2
        playerSprite.physicsBody = SKPhysicsBody(rectangleOfSize: self.playerSprite.size)
        playerSprite.physicsBody?.dynamic = true
        playerSprite.physicsBody?.affectedByGravity = true
        playerSprite.physicsBody?.allowsRotation = false
        
        playerSprite.physicsBody?.categoryBitMask = CollisionCategory.Player.rawValue
        playerSprite.physicsBody?.collisionBitMask = CollisionCategory.Floor.rawValue | CollisionCategory.Plateform.rawValue |
            CollisionCategory.Down.rawValue
        playerSprite.physicsBody?.contactTestBitMask = CollisionCategory.Floor.rawValue | CollisionCategory.Plateform.rawValue | CollisionCategory.Down.rawValue
    }
    
    func PlayerUpdate(view: SKView) {
//        view.scene!.anchorPoint = CGPoint(x: 0.5,y: 0.5)
//        
//        spriteArray.append(textureAtlas.textureNamed("Sperso1"));
//        spriteArray.append(textureAtlas.textureNamed("Sperso2"));
//        spriteArray.append(textureAtlas.textureNamed("Sperso3"));
//        spriteArray.append(textureAtlas.textureNamed("Sperso4"));
//        spriteArray.append(textureAtlas.textureNamed("Sperso5"));
//        spriteArray.append(textureAtlas.textureNamed("Sperso6"));
//        
//        playerSprite = SKSpriteNode(texture:spriteArray[0]);
//        
//        let animateAction = SKAction.animateWithTextures(self.spriteArray, timePerFrame: 0.20);
//        let moveAction = SKAction.moveBy(CGVector( dx: view.bounds.width, dy: 0), duration: 1.4);
//        let group = SKAction.group([ animateAction,moveAction]);
//        let repeatAction = SKAction.repeatActionForever(group);
//        self.playerSprite.runAction(repeatAction);
    }
    
    func positionFix() {
        if self.playerSprite.position.x != UIScreen.mainScreen().bounds.size.width / 3 {
            self.playerSprite.runAction(SKAction.moveToX(UIScreen.mainScreen().bounds.size.width / 3, duration: 0.5), completion: nil)
        }
    }
    
    func PlayerJump() {
        playerSprite.physicsBody?.velocity = CGVectorMake(0, 0)
        playerSprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 24))
    }
}