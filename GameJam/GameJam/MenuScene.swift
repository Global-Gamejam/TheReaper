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
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.runAction(SKAction.repeatActionForever(SKAction.playSoundFileNamed("main.mp3", waitForCompletion: true)))
        
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //  self.player.PlayerJump()


        super.touchesBegan(touches, withEvent: event)
        
        let location = touches.anyObject()?.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location!)
        
        if touchedNode.name == "play" {
            
            let skView = self.view! as SKView
            skView.ignoresSiblingOrder = true
            let scene = GameScene(size: skView.bounds.size, menu: self)
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
            
//            let transition = SKTransition.crossFadeWithDuration(0.1)
//            var myScene = GameScene(size: self.size, menu: self)
//            myScene.menu = self
//            skView.ignoresSiblingOrder = true
//            myScene.scaleMode = SKSceneScaleMode.AspectFill
//            self.view?.presentScene(myScene, transition: transition)
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        //  HouseContainer.updateBackGroundHouse(self)
        // GeneratePlateform.updatePlateform(self)
        //self.player.positionFix()
    }
}
