//
//  ParticuleManager.swift
//  GameJam
//
//  Created by Remi Robert on 08/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

class ParticuleManager: NSObject {
    class func runParticule(scene: SKScene, position: CGPoint) {
        let particulePath = NSBundle.mainBundle().pathForResource("Broke", ofType: "sks")
        let particule: SKEmitterNode? = NSKeyedUnarchiver.unarchiveObjectWithFile(particulePath!) as? SKEmitterNode
        
        particule?.particlePosition = position;
        particule?.zPosition = 4
        particule?.position = position
        scene.addChild(particule!)
    }
 }
