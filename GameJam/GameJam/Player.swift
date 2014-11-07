//
//  Player.swift
//  GameJam
//
//  Created by Julien on 07/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import Foundation
import SpriteKit

class Player  {
    
    let textureAtlas = SKTextureAtlas(named:"perso.atlas")
    var playerSprite = SKSpriteNode()
    var spriteArray = Array<SKTexture>();
    
    func PlayerInit()
    {
        // physicsWorld.gravity = CGVectorMake(0.0, -2.0)
        playerSprite.position = CGPoint(x: 0,y: 0)
        playerSprite.physicsBody = SKPhysicsBody(circleOfRadius: playerSprite.size.width/2)
        playerSprite.physicsBody?.dynamic = true
        playerSprite.physicsBody?.affectedByGravity = true
        playerSprite.physicsBody?.allowsRotation = false
    }
    
    func PlayerUpdate(view: SKView)
    {
        view.scene!.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        
        spriteArray.append(textureAtlas.textureNamed("Sperso1"));
        spriteArray.append(textureAtlas.textureNamed("Sperso2"));
        spriteArray.append(textureAtlas.textureNamed("Sperso3"));
        spriteArray.append(textureAtlas.textureNamed("Sperso4"));
        spriteArray.append(textureAtlas.textureNamed("Sperso5"));
        spriteArray.append(textureAtlas.textureNamed("Sperso6"));
        
        playerSprite = SKSpriteNode(texture:spriteArray[0]);
        
        let animateAction = SKAction.animateWithTextures(self.spriteArray, timePerFrame: 0.20);
        let moveAction = SKAction.moveBy(CGVector( dx: view.bounds.width, dy: 0), duration: 1.4);
        let group = SKAction.group([ animateAction,moveAction]);
        let repeatAction = SKAction.repeatActionForever(group);
        self.playerSprite.runAction(repeatAction);
    }
    
    func PlayerJump(view: SKView)
    {
        playerSprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 40))
    }
}