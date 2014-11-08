//
//  GameScene.swift
//  GameJam
//
//  Created by Remi Robert on 07/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player = Player()
    var monster = Monster()
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -10.0)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        HouseContainer.initHouseContainer(self)
        
        self.addChild(self.player.playerSprite)
        self.addChild(self.monster.node)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.player.PlayerJump()
    }

    override func update(currentTime: CFTimeInterval) {
        HouseContainer.updateBackGroundHouse(self)
        GeneratePlateform.updatePlateform(self)
    }
}
