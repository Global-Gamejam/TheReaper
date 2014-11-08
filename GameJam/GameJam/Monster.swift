//
//  Monster.swift
//  GameJam
//
//  Created by Remi Robert on 08/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

class Monster: NSObject {
    var node = SKSpriteNode(color: UIColor.grayColor(), size: CGSizeMake(60, 60))
    
    override init() {
        super.init()
        
        node.zPosition = 2
        node.position = CGPointMake(30, 30)
    }
}
