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
}
