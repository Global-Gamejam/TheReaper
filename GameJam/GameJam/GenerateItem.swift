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

        switch randomNumber {
        case 0, 1:
            let sprite = ["cabinet", "baseWatch"]
            node = PreloadData.makeSKSPriteNode(sprite[random() % 2])
            node.name = "itemBonus"
        case 2:
            let sprite = ["table", "armoire0", "tv"]
            let randNumber = random() % 3
            node = PreloadData.makeSKSPriteNode(sprite[Int(randNumber)])
            if randNumber == 2 {
                node.size = CGSizeMake(node.size.width + 1, node.size.height + 1)
            }
            node.name = "itemMalus"
        default: return Void()
        }

        
        node.position = CGPointMake(position.x, position.y + node.size.height / 2 + 7)
        switch randomNumber {
        case 0, 1:
            let tableAnimation = SKAction.sequence([SKAction.colorizeWithColor(UIColor.greenColor().colorWithAlphaComponent(0.8), colorBlendFactor: 1, duration: 0.5),
            SKAction.colorizeWithColorBlendFactor(0, duration: 0.5)])
            
            node.runAction(SKAction.repeatActionForever(tableAnimation))
        case 2:
            let tableAnimation = SKAction.sequence([SKAction.colorizeWithColor(UIColor.redColor().colorWithAlphaComponent(0.8), colorBlendFactor: 1, duration: 0.5),
                SKAction.colorizeWithColorBlendFactor(0, duration: 0.5)])
            
            node.runAction(SKAction.repeatActionForever(tableAnimation))
        default:Void()
        }
        node.zPosition = 3
        scene.addChild(node)
    }
}
