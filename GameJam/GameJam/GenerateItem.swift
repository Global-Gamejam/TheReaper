//
//  GenerateItem.swift
//  GameJam
//
//  Created by Remi Robert on 08/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

class GenerateItem: NSObject {
    class func addItem(scene: SKScene, position: CGPoint, widthSize: CGFloat) {
        let randomNumber = rand() % 3
        var node: SKSpriteNode!
        
        if randomNumber == 0 {
            node = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(10, 30))
        }
        else if randomNumber == 1 {
            node = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(10, 30))
        }
        else {
            node = SKSpriteNode(color: UIColor.orangeColor(), size: CGSizeMake(10, 30))
        }
        node.name = "item"
        node.shadowCastBitMask = 1
        node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
        node.physicsBody?.affectedByGravity = true
        node.position = CGPointMake((CGFloat(rand()) % (widthSize / 2)) + position.x, position.y + node.size.height / 2 + 7)
        
        switch randomNumber {
        case 0:
            node.physicsBody?.categoryBitMask = CollisionCategory.ItemBonus.rawValue
        case 1:
            node.physicsBody?.categoryBitMask = CollisionCategory.ItemMalus.rawValue
        case 2:
            node.physicsBody?.categoryBitMask = CollisionCategory.ItemNone.rawValue
        default:Void()
        }
        
        node.physicsBody?.collisionBitMask = CollisionCategory.Player.rawValue | CollisionCategory.Monster.rawValue |
            CollisionCategory.Floor.rawValue | CollisionCategory.Plateform.rawValue
//        node.physicsBody?.contactTestBitMask = CollisionCategory.Floor.rawValue |
//            CollisionCategory.Plateform.rawValue | CollisionCategory.Down.rawValue

        node.zPosition = 3
        
        scene.addChild(node)
    }
}
