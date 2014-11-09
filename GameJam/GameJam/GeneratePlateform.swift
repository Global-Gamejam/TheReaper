//
//  GeneratePlateform.swift
//  GameJam
//
//  Created by Remi Robert on 08/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

class GeneratePlateform: NSObject {
   
    private class func generateWollPlateform(scene: SKScene, currentPosition: CGPoint) {
        var plateform1 = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(CGFloat(rand()) % (scene.size.width / 2 - 320) + 50, 10))
        
        plateform1.position = CGPointMake(currentPosition.x - scene.size.width / 4 + plateform1.size.width / 2, scene.size.height / 3)
        plateform1.name = "floor"
        plateform1.zPosition = 2
        plateform1.physicsBody = SKPhysicsBody(rectangleOfSize: plateform1.size)
        plateform1.physicsBody?.resting = true
        plateform1.physicsBody?.mass = 100000000
        plateform1.physicsBody?.dynamic = false
        plateform1.physicsBody?.affectedByGravity = false
        plateform1.shadowCastBitMask = 1
        
        var plateform2 = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(scene.size.width / 2 - plateform1.size.width - 160, 10))
        
        plateform2.position = CGPointMake(currentPosition.x + scene.size.width / 4 - plateform2.size.width / 2, scene.size.height / 3)
        plateform2.name = "floor"
        plateform2.zPosition = 2
        plateform2.physicsBody = SKPhysicsBody(rectangleOfSize: plateform2.size)
        plateform2.physicsBody?.resting = true
        plateform2.physicsBody?.mass = 100000000
        plateform2.physicsBody?.dynamic = false
        plateform2.physicsBody?.affectedByGravity = false
        plateform2.shadowCastBitMask = 1
        
        plateform1.physicsBody?.categoryBitMask = CollisionCategory.Floor.rawValue
        plateform1.physicsBody?.collisionBitMask = CollisionCategory.Player.rawValue | CollisionCategory.Monster.rawValue
        plateform2.physicsBody?.categoryBitMask = CollisionCategory.Floor.rawValue
        plateform2.physicsBody?.collisionBitMask = CollisionCategory.Player.rawValue | CollisionCategory.Monster.rawValue
        
        GenerateItem.addItem(scene, position: plateform1.position, widthSize: plateform1.size.width)
        GenerateItem.addItem(scene, position: plateform2.position, widthSize: plateform2.size.width)
        
        scene.addChild(plateform1)
        scene.addChild(plateform2)
    }
    
    class func generateFloor(scene: SKScene, currentPosition: CGPoint) {
        if rand() % 4 == 0 {
            self.generateWollPlateform(scene, currentPosition: currentPosition)
            return Void()
        }
        
        var plateform = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(UIScreen.mainScreen().bounds.size.width / 2, 10))
        
        plateform.position = CGPointMake(currentPosition.x, scene.size.height / 3)
        plateform.name = "floor"
        plateform.zPosition = 2
        plateform.physicsBody = SKPhysicsBody(rectangleOfSize: plateform.size)
        plateform.physicsBody?.resting = true
        plateform.physicsBody?.mass = 100000000
        plateform.physicsBody?.dynamic = false
        plateform.physicsBody?.affectedByGravity = false
        plateform.shadowCastBitMask = 1
        
        plateform.physicsBody?.categoryBitMask = CollisionCategory.Floor.rawValue
        plateform.physicsBody?.collisionBitMask = CollisionCategory.Player.rawValue | CollisionCategory.Monster.rawValue |
            CollisionCategory.ItemMalus.rawValue | CollisionCategory.ItemBonus.rawValue | CollisionCategory.ItemNone.rawValue
        
        GenerateItem.addItem(scene, position: plateform.position, widthSize: plateform.size.width)
        
        scene.addChild(plateform)
    }
    
    class func generatePlateform(scene: SKScene, currentPosition: CGPoint) {
        if random() % 2 != 0 {
            return Void()
        }
        var plateform = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(UIScreen.mainScreen().bounds.size.width / 2, 10))
        
        plateform.position = CGPointMake(currentPosition.x, scene.size.height - scene.size.height / 3)
        plateform.name = "plateform"
        plateform.zPosition = 2
        plateform.physicsBody = SKPhysicsBody(rectangleOfSize: plateform.size)
        plateform.physicsBody?.resting = true
        plateform.physicsBody?.mass = 100000000
        plateform.physicsBody?.dynamic = false
        plateform.physicsBody?.affectedByGravity = false
        plateform.shadowCastBitMask = 1
        
        plateform.physicsBody?.categoryBitMask = CollisionCategory.Plateform.rawValue
        plateform.physicsBody?.collisionBitMask = CollisionCategory.Player.rawValue | CollisionCategory.Monster.rawValue
        
        GenerateItem.addItem(scene, position: plateform.position, widthSize: plateform.size.width)
        
        scene.addChild(plateform)
    }
    
    class func updatePlateform(scene: SKScene) {
        scene.enumerateChildNodesWithName("plateform", usingBlock: { (node: SKNode!, obj:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.position = CGPointMake(node.position.x - HouseContainer.sharedInstance.currentSpeed, node.position.y)
            if node.position.x + node.frame.size.width / 2 <= 0 {
                node.removeFromParent()
            }
        })
        
        scene.enumerateChildNodesWithName("floor", usingBlock: { (node: SKNode!, obj:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.position = CGPointMake(node.position.x - HouseContainer.sharedInstance.currentSpeed, node.position.y)
            if node.position.x + node.frame.size.width / 2 <= 0 {
                node.removeFromParent()
            }
        })
        
        scene.enumerateChildNodesWithName("item", usingBlock: { (node: SKNode!, obj:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.position = CGPointMake(node.position.x - HouseContainer.sharedInstance.currentSpeed, node.position.y)
            
            if node.position.x + node.frame.size.width / 2 <= 0 {
                node.removeFromParent()
            }
        })

        scene.enumerateChildNodesWithName("itemBonus", usingBlock: { (node: SKNode!, obj:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.position = CGPointMake(node.position.x - HouseContainer.sharedInstance.currentSpeed, node.position.y)
            
            if node.position.x + node.frame.size.width / 2 <= 0 {
                node.removeFromParent()
            }
        })

        scene.enumerateChildNodesWithName("itemMalus", usingBlock: { (node: SKNode!, obj:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.position = CGPointMake(node.position.x - HouseContainer.sharedInstance.currentSpeed, node.position.y)
            
            if node.position.x + node.frame.size.width / 2 <= 0 {
                node.removeFromParent()
            }
        })
        
        scene.enumerateChildNodesWithName("monsterAdd", usingBlock: { (node: SKNode!, objc: UnsafeMutablePointer<ObjCBool>) -> Void in
            node.position = CGPointMake(node.position.x - HouseContainer.sharedInstance.currentSpeed, node.position.y)
            
            if node.position.x + node.frame.size.width / 2 <= 0 {
                node.removeFromParent()
            }
        })

    }
    
}
