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
   
    class func generateFloor(scene: SKScene, currentPosition: CGPoint) {
        var plateform = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(UIScreen.mainScreen().bounds.size.width / 2, 10))
        
        plateform.position = CGPointMake(currentPosition.x, scene.size.height / 3)
        plateform.name = "floor"
        plateform.zPosition = 2
        plateform.physicsBody = SKPhysicsBody(rectangleOfSize: plateform.size)
        plateform.physicsBody?.resting = true
        plateform.physicsBody?.mass = 100000000
        plateform.physicsBody?.dynamic = false
        plateform.physicsBody?.affectedByGravity = false
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

    }
    
}
