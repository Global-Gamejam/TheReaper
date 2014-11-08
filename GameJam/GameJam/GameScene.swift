//
//  GameScene.swift
//  GameJam
//
//  Created by Remi Robert on 07/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var floorPlateform: SKSpriteNode!
    var player = Player()
    var monster = Monster()
    var currentTime: NSTimeInterval = 0
    
    func initFloorPlateform() {
        self.floorPlateform = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(self.size.width, 10))
        
        self.floorPlateform.position = CGPointMake(self.size.width / 2, 5)
        
        self.floorPlateform.physicsBody = SKPhysicsBody(rectangleOfSize: self.floorPlateform.size)
        self.floorPlateform.physicsBody?.resting = true
        self.floorPlateform.physicsBody?.mass = 100000000
        self.floorPlateform.physicsBody?.dynamic = false
        self.floorPlateform.physicsBody?.affectedByGravity = false

        self.floorPlateform.physicsBody?.categoryBitMask = CollisionCategory.Down.rawValue
        self.floorPlateform.physicsBody?.collisionBitMask = CollisionCategory.Player.rawValue | CollisionCategory.Monster.rawValue

        self.floorPlateform.name = "down"
        self.floorPlateform.zPosition = 2
        self.addChild(self.floorPlateform)
    }
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -10.0)
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        HouseContainer.initHouseContainer(self)
        
        self.initFloorPlateform()
        
        self.addChild(self.player.playerSprite)
        //self.addChild(self.player.ligth)
        self.addChild(self.monster.node)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.player.PlayerJump()
    }

    override func update(currentTime: CFTimeInterval) {
        if self.currentTime == 0 {
            self.currentTime += 3
        }
        
        HouseContainer.updateBackGroundHouse(self)
        GeneratePlateform.updatePlateform(self)
        if self.currentTime <= currentTime {
            //self.addMonster()
            self.currentTime = currentTime + 3
        }
        //self.player.positionFix()
    }
}
