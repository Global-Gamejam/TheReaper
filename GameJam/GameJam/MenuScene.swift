//
//  MenuScene.swift
//  GameJam
//
//  Created by Julien on 09/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var play: SKLabelNode!
    var player = Player()
    var monster = Monster()
    
    override func didMoveToView(view: SKView) {
        self.play = SKLabelNode(text: "PLAY")
        self.play.position = CGPointMake(self.size.width / 2 + 50 , self.size.height / 2)
        self.play.fontSize = 100
        self.play.name = "play"
        
        //        self.addChild(self.player.playerSprite)
        //        //self.addChild(self.player.ligth)
        
        self.monster.node.xScale = 2
        self.monster.node.yScale = 2
        self.monster.node.position = CGPointMake(200, self.size.height / 3 + self.monster.node.size.height / 2)
        
        
        
        self.player.playerSprite.xScale = 2
        self.player.playerSprite.yScale = 2
        self.player.playerSprite.physicsBody?.affectedByGravity = false
        self.player.playerSprite.position = CGPointMake(self.size.width - 200, self.size.height / 3 + self.player.playerSprite.size.height / 2 + 50)

        self.player.ligth.enabled = false
        
        self.addChild(self.monster.node)
        self.addChild(self.play)
        self.addChild(self.player.playerSprite)

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //  self.player.PlayerJump()


        super.touchesBegan(touches, withEvent: event)
        
        let location = touches.anyObject()?.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location!)
        
        if touchedNode.name == "play" {
            println("totot")
            let transition = SKTransition.crossFadeWithDuration(0.1)
            let myScene = GameScene(size: self.size)
            myScene.scaleMode = SKSceneScaleMode.AspectFill
            self.view?.presentScene(myScene, transition: transition)
        }
        
        
        
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        //  HouseContainer.updateBackGroundHouse(self)
        // GeneratePlateform.updatePlateform(self)
        //self.player.positionFix()
    }
}
