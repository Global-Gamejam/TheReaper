//
//  House.swift
//  GameJam
//
//  Created by Remi Robert on 07/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

enum HousePart {
    case Begin
    case Inter
    case End
    case Ext
    
    func getSKSPriteNode() -> SKSpriteNode {
        var spriteName: String? = nil
        switch self {
        case Begin:
            spriteName = "begin_house"
        case Inter:
            spriteName = "inter"
        case End:
            spriteName = "end_house"
        case Ext:
            spriteName = "ext"
        }
        var sprite = SKSpriteNode(imageNamed: spriteName!)
        sprite.name = spriteName
        return sprite
    }
}

class House: NSObject {
    var housePart = Array<HousePart>()
    var HouseKind: Int = 0
    
    class func generateHouse(currentLevel: Int) -> House {
        var newHouse = House()
        
        if currentLevel == 1 {
            newHouse.housePart.append(HousePart.Ext)
            newHouse.housePart.append(HousePart.Ext)
        }
        
        newHouse.housePart.append(HousePart.Ext)
        newHouse.housePart.append(HousePart.Begin)
        for var index = 0; index < currentLevel; index++ {
            newHouse.housePart.append(HousePart.Inter)
        }
        newHouse.housePart.append(HousePart.End)
        newHouse.housePart.append(HousePart.Ext)
        return newHouse
    }
}

class HouseContainer: NSObject {
    var container = Array<House>()
    var index: Int = 2
    var currentSprite = Array<SKSpriteNode>()
    var currentSpeed: CGFloat = 3.0

    class var sharedInstance: HouseContainer {
        struct Static {
            static let instance: HouseContainer = HouseContainer()
        }
        return Static.instance
    }
    
    private class func initSpriteHousePart(scene: SKScene) {
        var positionX: CGFloat = UIScreen.mainScreen().bounds.size.height / 2
        for var index = 0; index < 3; index++ {
            var currentSprite: SKSpriteNode = HousePart.getSKSPriteNode(self.sharedInstance.container[0].housePart[index])()
            currentSprite.position = CGPointMake(positionX, currentSprite.size.height / 2)
            
            GeneratePlateform.generateFloor(scene, currentPosition: currentSprite.position)
            self.sharedInstance.currentSprite.append(currentSprite)
            positionX += currentSprite.size.width
            scene.addChild(currentSprite)
        }
    }
    
    class func initHouseContainer(scene: SKScene) {
        for var index = 1; index < 20; index++ {
            self.sharedInstance.container.append(House.generateHouse(index))
        }
        self.initSpriteHousePart(scene)
    }
    
    private class func addNewSpriteWithCurrentIndex(scene: SKScene) {
        var currentIndexPosition = 0

        for currentHouseContainer in self.sharedInstance.container {
            if self.sharedInstance.index < currentHouseContainer.housePart.count + currentIndexPosition {
                currentIndexPosition = self.sharedInstance.index - currentIndexPosition

                var newSprite: SKSpriteNode = HousePart.getSKSPriteNode(currentHouseContainer.housePart[currentIndexPosition])()
                newSprite.position = CGPointMake(self.sharedInstance.currentSprite[1].position.x + self.sharedInstance.currentSprite[1].size.width,
                    newSprite.size.height / 2)
                scene.addChild(newSprite)
                
                GeneratePlateform.generateFloor(scene, currentPosition: newSprite.position)
                if newSprite.name == "inter" {
                    GeneratePlateform.generatePlateform(scene, currentPosition: newSprite.position)
                }
                
                self.sharedInstance.currentSprite.append(newSprite)
                return ;
            }
            currentIndexPosition += currentHouseContainer.housePart.count
        }
    }
    
    private class func regenateSpriteContainer(scene: SKScene) {
        if self.sharedInstance.currentSprite[0].position.x + (self.sharedInstance.currentSprite[0].size.width / 2) <= 0 {
            if self.sharedInstance.currentSprite[0].name == "end_house" {
                self.sharedInstance.currentSpeed += 1
            }
            self.sharedInstance.currentSprite[0].removeFromParent()
            self.sharedInstance.currentSprite.removeAtIndex(0)
            self.sharedInstance.index += 1

            self.addNewSpriteWithCurrentIndex(scene)
        }
    }
    
    class func updateBackGroundHouse(scene: SKScene) {
        for currentSprite in self.sharedInstance.currentSprite {
            currentSprite.position = CGPointMake(currentSprite.position.x - self.sharedInstance.currentSpeed, currentSprite.position.y)
        }
        self.regenateSpriteContainer(scene)
    }
}
