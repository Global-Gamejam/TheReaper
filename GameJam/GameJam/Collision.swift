//
//  Collision.swift
//  GameJam
//
//  Created by Remi Robert on 08/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

enum CurrentPosition {
    case Down
    case Floor
    case Up
}

enum CollisionCategory: UInt32 {
    case Player = 1
    case Floor = 2
    case Plateform = 3
    case Monster = 4
    case Down = 5
    case ItemMalus = 6
    case ItemBonus = 7
    case ItemNone = 8
    case Monster1 = 9
}

extension GameScene: SKPhysicsContactDelegate {

    private func checkPositionPlayer() {
        if self.player.playerSprite.position.y < self.size.height / 3 {
            self.player.currentStatus = CurrentPosition.Down
        }
        else if self.player.playerSprite.position.y > self.size.height / 3 &&
            self.player.playerSprite.position.y < self.size.height - self.size.height / 3 {
            self.player.currentStatus = CurrentPosition.Floor
        }
        else {
            self.player.currentStatus = CurrentPosition.Up
        }
    }
    
    private func handlePLayerCollision(categoryNode: (CollisionCategory, CollisionCategory)) {
        switch categoryNode {
        case (CollisionCategory.Player, CollisionCategory.Floor), (CollisionCategory.Floor, CollisionCategory.Player):
            self.player.currentStatus = CurrentPosition.Floor
        case (CollisionCategory.Player, CollisionCategory.Plateform), (CollisionCategory.Plateform, CollisionCategory.Player):
            self.player.currentStatus = CurrentPosition.Up
        case (CollisionCategory.Player, CollisionCategory.Down), (CollisionCategory.Down, CollisionCategory.Player):
            self.player.currentStatus = CurrentPosition.Down
        default: Void()
        }
    }
    
    private func handleItemCollision(categoryNode: (CollisionCategory, CollisionCategory), node: SKNode) {
        switch categoryNode {
        case (CollisionCategory.Player, CollisionCategory.ItemMalus), (CollisionCategory.ItemMalus, CollisionCategory.Player):Void()
        case (CollisionCategory.Player, CollisionCategory.ItemNone), (CollisionCategory.ItemNone, CollisionCategory.Player):
            node.removeFromParent()
            //run Particule
            //ParticuleManager.runParticule(self, position: node.position)
        case (CollisionCategory.Player, CollisionCategory.ItemBonus), (CollisionCategory.ItemBonus, CollisionCategory.Player):
            if self.player.playerSprite.position.x + 5 <= self.size.width / 2 {
                println(node.name)
                node.removeFromParent()
                self.player.playerSprite.runAction(SKAction.moveToX(self.player.playerSprite.position.x + 5, duration: 0.5))
            }
        default: return Void()
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == nil || contact.bodyB.node?.name == nil {
            return Void()
        }
        
        let categoryNode: (CollisionCategory, CollisionCategory) = (CollisionCategory(rawValue:
            (contact.bodyA.node?.physicsBody!.categoryBitMask)!)!,
            CollisionCategory(rawValue: (contact.bodyB.node?.physicsBody!.categoryBitMask)!)!)
        let tmpCategory = self.player.currentStatus

        self.handlePLayerCollision(categoryNode)
        if tmpCategory != self.player.currentStatus {
            self.checkPositionPlayer()
            self.monster.updatePosition(self.player)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == nil || contact.bodyB.node?.name == nil {
            return Void()
        }
        
        let categoryNode: (CollisionCategory, CollisionCategory) = (CollisionCategory(rawValue:
            (contact.bodyA.node?.physicsBody!.categoryBitMask)!)!,
            CollisionCategory(rawValue: (contact.bodyB.node?.physicsBody!.categoryBitMask)!)!)
 
        self.handleItemCollision(categoryNode, node: ((contact.bodyA.node!.name! == "player") ? contact.bodyB.node! : contact.bodyA.node!))
    }
}
