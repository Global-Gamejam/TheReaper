//
//  GenerateItem.swift
//  GameJam
//
//  Created by Remi Robert on 08/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

extension GameScene {
    func applyItemEffect() {
        
    }
}

class GenerateItem: NSObject {
    class func addItem(scene: SKScene, position: CGPoint, widthSize: CGFloat) {
        let randomNumber = rand() % 3
        var node: SKSpriteNode!

        if randomNumber == 0 {
            node = PreloadData.makeSKSPriteNode("cabinet")
        }
        else if randomNumber == 1 {
            node = PreloadData.makeSKSPriteNode("table")
        }
        else {
            node = PreloadData.makeSKSPriteNode("chair")
        }
        node.name = "item"
        
        node.position = CGPointMake(position.x, position.y + node.size.height / 2 + 7)
        node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
        node.physicsBody?.affectedByGravity = true
//        node.position = CGPointMake((CGFloat(rand()) % (widthSize / 2)) + position.x,
//            position.y + node.size.height / 2 + 7)
        
        switch randomNumber {
        case 0:
            node.physicsBody?.categoryBitMask = CollisionCategory.ItemBonus.rawValue
            let tableAnimation = SKAction.sequence([SKAction.colorizeWithColor(UIColor.greenColor().colorWithAlphaComponent(0.8), colorBlendFactor: 1, duration: 0.5),
            SKAction.colorizeWithColorBlendFactor(0, duration: 0.5)])
            
            node.runAction(SKAction.repeatActionForever(tableAnimation))
        case 1:
            node.physicsBody?.categoryBitMask = CollisionCategory.ItemMalus.rawValue

            let tableAnimation = SKAction.sequence([SKAction.colorizeWithColor(UIColor.redColor().colorWithAlphaComponent(0.8), colorBlendFactor: 1, duration: 0.5),
                SKAction.colorizeWithColorBlendFactor(0, duration: 0.5)])
            
            node.runAction(SKAction.repeatActionForever(tableAnimation))

        case 2:
            node.physicsBody?.categoryBitMask = CollisionCategory.ItemNone.rawValue
        default:Void()
        }
        
        node.physicsBody?.usesPreciseCollisionDetection = true
        
        node.physicsBody?.collisionBitMask = CollisionCategory.Player.rawValue | CollisionCategory.Plateform.rawValue
        node.physicsBody?.contactTestBitMask = CollisionCategory.Player.rawValue | CollisionCategory.Floor.rawValue |
            CollisionCategory.Plateform.rawValue | CollisionCategory.Down.rawValue

        node.zPosition = 3
        
        scene.addChild(node)
    }
}
