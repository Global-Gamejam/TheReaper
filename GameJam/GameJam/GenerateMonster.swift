//
//  GenerateMonster.swift
//  GameJam
//
//  Created by Remi Robert on 08/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

extension GameScene {
    
    func addMereMonster() {
        var framesAnimations = Array<SKTexture>()
        var node = PreloadData.makeSKSPriteNode("mere1")
        
        
        for var index = 1; index < 11; index++ {
            framesAnimations.append(PreloadData.getData("mere\(index)") as SKTexture)
        }
        

        let animation = SKAction.sequence([SKAction.animateWithTextures(framesAnimations, timePerFrame: 0.05)])
        node.runAction(SKAction.repeatActionForever(animation))
        
        node.name = "secondMonster"
        
        if rand() % 3 == 0 {
            node.position = CGPointMake(self.size.width + node.size.width / 2, self.size.height / 3 + node.size.height / 2)
        }
        else {
            node.position = CGPointMake(self.size.width + node.size.width / 2, node.size.height / 2)
        }
        node.zPosition = 2
                
        self.addChild(node)
    }
    
    func addRampeurMonster() {
        var framesAnimations = Array<SKTexture>()
        var node = PreloadData.makeSKSPriteNode("anim1")
        
        
        for var index = 1; index < 11; index++ {
            framesAnimations.append(PreloadData.getData("anim\(index)") as SKTexture)
        }
        
        
        let animation = SKAction.sequence([SKAction.animateWithTextures(framesAnimations, timePerFrame: 0.05)])
        node.runAction(SKAction.repeatActionForever(animation))
        
        node.name = "secondMonster"
        
        if rand() % 3 == 0 {
            node.position = CGPointMake(self.size.width + node.size.width / 2, self.size.height / 3 + node.size.height / 2)
        }
        else {
            node.position = CGPointMake(self.size.width + node.size.width / 2, node.size.height / 2)
        }
        node.zPosition = 2
        
        self.addChild(node)
    }
    
    func addSuiveurMonster() {
        var framesAnimations = Array<SKTexture>()
        var node = PreloadData.makeSKSPriteNode("suiveur1")
        
        
        for var index = 1; index < 9; index++ {
            framesAnimations.append(PreloadData.getData("suiveur\(index)") as SKTexture)
        }
        
        node.size = CGSizeMake(node.size.width + 5, node.size.height + 5)
        
        let animation = SKAction.sequence([SKAction.animateWithTextures(framesAnimations, timePerFrame: 0.05)])
        node.runAction(SKAction.repeatActionForever(animation))
        
        node.name = "secondMonster"
        
        if rand() % 3 == 0 {
            node.position = CGPointMake(self.size.width + node.size.width / 2, self.size.height / 3 + node.size.height / 2)
        }
        else {
            node.position = CGPointMake(self.size.width + node.size.width / 2, node.size.height / 2)
        }
        node.zPosition = 2
        
        self.addChild(node)
    }
    
    func addMonster() {
        let number = rand() % 3
        if number == 0 {
            self.addMereMonster()
        }
        else if (number == 1) {
            self.addRampeurMonster()
        }
        else {
            self.addSuiveurMonster()
        }
    }
}
