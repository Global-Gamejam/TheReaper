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
    var currentTimeSong: NSTimeInterval = 0
    var brume = PreloadData.makeSKSPriteNode("brume")
    var currentSong = 0
    var gameOver: Bool = false
    var menu: MenuScene?
    
    init(size: CGSize, menu: MenuScene) {
        super.init(size: size)
        self.menu = menu
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        self.brume.position = CGPointMake(self.size.width + self.brume.size.width / 2, self.size.height / 3 + self.brume.size.height / 2)
        self.brume.zPosition = 3
        self.addChild(self.brume)
    }
    
    override func didMoveToView(view: SKView) {
        self.gameOver = false
        self.physicsWorld.gravity = CGVectorMake(0.0, -10.0)
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        HouseContainer.initHouseContainer(self)
        
        self.initFloorPlateform()
        
        self.addChild(self.player.playerSprite)
        self.addChild(self.monster.node)
        
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if self.gameOver == false {
            self.player.PlayerJump()
        }
    }

    func detectCollisionItem() {
        self.enumerateChildNodesWithName("itemMalus", usingBlock: { (node: SKNode!, objc: UnsafeMutablePointer<ObjCBool>) -> Void in
            
            if node.intersectsNode(self.player.playerSprite) {
                self.player.playerSprite.runAction(SKAction.playSoundFileNamed("crash.mp3", waitForCompletion: true))
                self.player.playerSprite.position = CGPointMake(self.player.playerSprite.position.x - 25, self.player.playerSprite.position.y)
                
                node.name = "item"
                switch (node.frame.size.width, node.frame.size.height) {
                case (64.5, 75.0):
                    node.runAction(SKAction.animateWithTextures([PreloadData.getData("table+bouteilles1"),
                        PreloadData.getData("table+bouteilles2"), PreloadData.getData("table+bouteilles3"),
                        PreloadData.getData("table+bouteilles4")], timePerFrame: 0.04, resize: true, restore: false))
                    break
                case (39.0, 78.5):
                    node.position = CGPointMake(node.position.x + 30, node.position.y + 30)
                    node.runAction(SKAction.animateWithTextures([PreloadData.getData("armoire1"),
                        PreloadData.getData("armoire2"), PreloadData.getData("armoire3"),
                        PreloadData.getData("armoire4")], timePerFrame: 0.04, resize: true, restore: false))
                    break
                case (65.5, 113.0):
                    node.runAction(SKAction.animateWithTextures([PreloadData.getData("TV1"),
                        PreloadData.getData("TV2"), PreloadData.getData("TV3"),
                        PreloadData.getData("TV4")], timePerFrame: 0.04, resize: true, restore: false))
                    break
                default: return Void()
                }
            }
            
        })

        self.enumerateChildNodesWithName("itemBonus", usingBlock: { (node: SKNode!, objc: UnsafeMutablePointer<ObjCBool>) -> Void in
            if node.intersectsNode(self.player.playerSprite) {
                node.name = "item"
            
                println("\(node.frame.size)")

                self.player.playerSprite.runAction(SKAction.playSoundFileNamed("crash.mp3", waitForCompletion: true))

                self.player.playerSprite.position = CGPointMake(self.player.playerSprite.position.x + 20, self.player.playerSprite.position.y)
                switch (node.frame.size.width, node.frame.size.height) {
                case (105.5, 110):
                    node.position = CGPointMake(node.position.x, node.position.y + 20)
                    node.runAction(SKAction.animateWithTextures([PreloadData.getData("animcabinet1"),
                        PreloadData.getData("animcabinet2"), PreloadData.getData("animcabinet3"),
                        PreloadData.getData("animcabinet4")], timePerFrame: 0.04, resize: true, restore: false))
                case (49.0, 105.5):
                    node.position = CGPointMake(node.position.x, node.position.y + 20)
                    node.runAction(SKAction.animateWithTextures([PreloadData.getData("watch1"),
                        PreloadData.getData("watch2"), PreloadData.getData("watch3"),
                        PreloadData.getData("watch4")], timePerFrame: 0.04, resize: true, restore: false))
                case (114.0,65.5):
                    node.position = CGPointMake(node.position.x, node.position.y + 30)
                    node.runAction(SKAction.animateWithTextures([PreloadData.getData("bibli1"),
                        PreloadData.getData("bibli2"), PreloadData.getData("bibli3"),
                        PreloadData.getData("bibli4")], timePerFrame: 0.04, resize: true, restore: false))
                default: Void()
                }
            }
        })
        
    }
    
    func displayMenu() {
        self.removeAllChildren()
        //self.didMoveToView(self.view!)
        self.view?.presentScene(self.menu)
        NSNotificationCenter.defaultCenter().postNotificationName("displayScene", object: nil)
    }
    
    func checkCollisionSecondMonster() {
        self.enumerateChildNodesWithName("secondMonster", usingBlock: { (node: SKNode!, objc: UnsafeMutablePointer<ObjCBool>) -> Void in
            if node.intersectsNode(self.player.playerSprite) {
                
                self.gameOver = true
                let spriteShader = SKSpriteNode(color: UIColor.blackColor().colorWithAlphaComponent(0.7), size: self.size)
                spriteShader.position = CGPointMake(self.size.width / 2, self.size.height / 2)
                spriteShader.zPosition = 5
                self.addChild(spriteShader)
                
                switch (node.frame.size.width, node.frame.size.height) {
                case (105, 105):
                    var sprite = PreloadData.makeSKSPriteNode("rframe1")
                    sprite.size = CGSizeMake(sprite.size.width * 2, sprite.size.height * 2)

                    sprite.zPosition = 10
                    sprite.position = CGPointMake(self.size.width / 2, self.size.height / 2)
                    
                    var arrayTexture = Array<SKTexture>()
                    
                    for var index = 1; index < 10; index++ {
                        arrayTexture.append((PreloadData.getData("rframe\(index)") as SKTexture))
                    }
                    
                    sprite.runAction(SKAction.animateWithTextures(arrayTexture, timePerFrame: 0.2), completion: { () -> Void in
                        sprite.runAction(SKAction.waitForDuration(2), completion: { () -> Void in
                            self.displayMenu()
                        })
                    })
                    self.addChild(sprite)
                    
                case (125.0, 125.0):
                    var sprite = PreloadData.makeSKSPriteNode("kill1")
                    sprite.size = CGSizeMake(sprite.size.width * 2, sprite.size.height * 2)
                    sprite.zPosition = 10
                    sprite.position = CGPointMake(self.size.width / 2, self.size.height / 2)
                    
                    var arrayTexture = Array<SKTexture>()
                    
                    for var index = 1; index < 9; index++ {
                        arrayTexture.append((PreloadData.getData("kill\(index)") as SKTexture))
                    }
                    
                    sprite.runAction(SKAction.animateWithTextures(arrayTexture, timePerFrame: 0.2), completion: { () -> Void in
                        sprite.runAction(SKAction.waitForDuration(2), completion: { () -> Void in
                            self.displayMenu()
                        })
                    })
                    self.addChild(sprite)
                 
                default:
                    var sprite = PreloadData.makeSKSPriteNode("frag1")
                    sprite.size = CGSizeMake(sprite.size.width * 2, sprite.size.height * 2)
                    
                    sprite.zPosition = 10
                    sprite.position = CGPointMake(self.size.width / 2, self.size.height / 2)
                    
                    var arrayTexture = Array<SKTexture>()
                    
                    for var index = 1; index < 9; index++ {
                        arrayTexture.append((PreloadData.getData("frag\(index)") as SKTexture))
                    }
                    
                    sprite.runAction(SKAction.animateWithTextures(arrayTexture, timePerFrame: 0.2), completion: { () -> Void in
                        sprite.runAction(SKAction.waitForDuration(2), completion: { () -> Void in
                            self.displayMenu()
                        })
                    })
                    self.addChild(sprite)

                }
                
            }
        })
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        if self.gameOver == true {
            return Void()
        }
        
        if self.monster.node.intersectsNode(self.player.playerSprite) {
            self.gameOver = true
            
            let spriteShader = SKSpriteNode(color: UIColor.blackColor().colorWithAlphaComponent(0.7), size: self.size)
            spriteShader.position = CGPointMake(self.size.width / 2, self.size.height / 2)
            spriteShader.zPosition = 5
            self.addChild(spriteShader)
            
            var sprite = PreloadData.makeSKSPriteNode("tue1")
            sprite.size = CGSizeMake(sprite.size.width * 2, sprite.size.height * 2)
            sprite.zPosition = 10
            sprite.position = CGPointMake(self.size.width / 2, self.size.height / 2)
            
            var arrayTexture = Array<SKTexture>()
            
            for var index = 1; index < 12; index++ {
                arrayTexture.append((PreloadData.getData("tue\(index)") as SKTexture))
            }

            sprite.runAction(SKAction.animateWithTextures(arrayTexture, timePerFrame: 0.2), completion: { () -> Void in
                sprite.runAction(SKAction.waitForDuration(2), completion: { () -> Void in
                    self.displayMenu()                    
                })
            })
            self.addChild(sprite)
            return Void()
        }
        
        if self.currentTime == 0 {
            self.currentTime += 3
        }
        if self.currentTimeSong == 0 {
            self.currentTimeSong += 0
        }
        self.brume.position = CGPointMake(self.brume.position.x - 1, self.brume.position.y)
        
        HouseContainer.updateBackGroundHouse(self)
        GeneratePlateform.updatePlateform(self)
        if self.currentTime <= currentTime {
            self.addMonster()
            self.currentTime = currentTime + Double(rand() % 5) + 1
        }
        
        if self.currentTimeSong <= currentTime {
            self.runAction(SKAction.playSoundFileNamed("Cri_\(self.currentSong).wav", waitForCompletion: true))
            self.currentSong += 1
            if self.currentSong == 4 {
                self.currentSong = 0
            }
            self.currentTimeSong += currentTime + 10
        }
        
        self.enumerateChildNodesWithName("secondMonster", usingBlock: { (node: SKNode!, objc: UnsafeMutablePointer<ObjCBool>) -> Void in
            node.position = CGPointMake(node.position.x - HouseContainer.sharedInstance.currentSpeed - 0.5, node.position.y)
            
            if node.position.x + node.frame.size.width / 2 <= 0 {
                node.removeFromParent()
            }
        })
        
        self.detectCollisionItem()
        self.checkCollisionSecondMonster()
        
        //self.player.positionFix()
    }
}
