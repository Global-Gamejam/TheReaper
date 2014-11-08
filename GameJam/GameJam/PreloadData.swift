//
//  PreloadData.swift
//  GameJam
//
//  Created by Remi Robert on 08/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

class PreloadData: NSObject {
    var data = Dictionary<String, AnyObject>()
    
    class var sharedInstance: PreloadData {
        struct Static {
            static let instance: PreloadData = PreloadData()
        }
        return Static.instance
    }
    
    class func addData(data: AnyObject, key: String) {
        self.sharedInstance.data[key] = data
    }
    
    class func getData(key: String) -> AnyObject! {
        return self.sharedInstance.data[key]
    }
    
    class func makeSKSPriteNode(key: String) -> SKSpriteNode! {
        if let texture: AnyObject = self.sharedInstance.data[key] {
            if texture.isKindOfClass(SKTexture.self) {
                return SKSpriteNode(texture: (texture as SKTexture))
            }
        }
        return nil
    }
}
