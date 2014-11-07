//
//  GameScene.swift
//  GameJam
//
//  Created by Remi Robert on 07/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        HouseContainer.initHouseContainer(self)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }

    override func update(currentTime: CFTimeInterval) {
        HouseContainer.updateBackGroundHouse(self)
    }
}
