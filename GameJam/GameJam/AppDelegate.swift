//
//  AppDelegate.swift
//  GameJam
//
//  Created by Remi Robert on 07/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func loadData() {
        //background loading
        PreloadData.addData(SKTexture(imageNamed: "0begin_house"), key: "0begin_house")
        PreloadData.addData(SKTexture(imageNamed: "0end_house"), key: "0end_house")
        PreloadData.addData(SKTexture(imageNamed: "0inter0"), key: "0inter0")
        PreloadData.addData(SKTexture(imageNamed: "0inter1"), key: "0inter1")
        PreloadData.addData(SKTexture(imageNamed: "ext"), key: "ext")

        PreloadData.addData(SKTexture(imageNamed: "1begin_house"), key: "1begin_house")
        PreloadData.addData(SKTexture(imageNamed: "1end_house"), key: "1end_house")
        PreloadData.addData(SKTexture(imageNamed: "1inter0"), key: "1inter0")
        PreloadData.addData(SKTexture(imageNamed: "1inter1"), key: "1inter1")
        
        //item loading
        PreloadData.addData(SKTexture(imageNamed: "cabinet"), key: "cabinet")
        PreloadData.addData(SKTexture(imageNamed: "chair"), key: "chair")
        PreloadData.addData(SKTexture(imageNamed: "table"), key: "table")
        PreloadData.addData(SKTexture(imageNamed: "baseWatch"), key: "baseWatch")

        PreloadData.addData(SKTexture(imageNamed: "brume"), key: "brume")

        PreloadData.addData(SKTexture(imageNamed: "table+bouteilles1"), key: "table+bouteilles1")
        PreloadData.addData(SKTexture(imageNamed: "table+bouteilles2"), key: "table+bouteilles2")
        PreloadData.addData(SKTexture(imageNamed: "table+bouteilles3"), key: "table+bouteilles3")
        PreloadData.addData(SKTexture(imageNamed: "table+bouteilles4"), key: "table+bouteilles4")
        
        PreloadData.addData(SKTexture(imageNamed: "bibli1"), key: "bibli1")
        PreloadData.addData(SKTexture(imageNamed: "bibli2"), key: "bibli2")
        PreloadData.addData(SKTexture(imageNamed: "bibli3"), key: "bibli3")
        PreloadData.addData(SKTexture(imageNamed: "bibli4"), key: "bibli4")
        
        //monster loading
        PreloadData.addData(SKTexture(imageNamed: "monster1"), key: "monster1")
        PreloadData.addData(SKTexture(imageNamed: "monster2"), key: "monster2")
        PreloadData.addData(SKTexture(imageNamed: "monster3"), key: "monster3")
        PreloadData.addData(SKTexture(imageNamed: "monster4"), key: "monster4")
        
        PreloadData.addData(SKTexture(imageNamed: "watch1"), key: "watch1")
        PreloadData.addData(SKTexture(imageNamed: "watch2"), key: "watch2")
        PreloadData.addData(SKTexture(imageNamed: "watch3"), key: "watch3")
        PreloadData.addData(SKTexture(imageNamed: "watch4"), key: "watch4")
        
        PreloadData.addData(SKTexture(imageNamed: "armoire0"), key: "armoire0")
        PreloadData.addData(SKTexture(imageNamed: "armoire1"), key: "armoire1")
        PreloadData.addData(SKTexture(imageNamed: "armoire2"), key: "armoire2")
        PreloadData.addData(SKTexture(imageNamed: "armoire3"), key: "armoire3")
        PreloadData.addData(SKTexture(imageNamed: "armoire4"), key: "armoire4")

        PreloadData.addData(SKTexture(imageNamed: "tv"), key: "tv")
        PreloadData.addData(SKTexture(imageNamed: "TV1"), key: "TV1")
        PreloadData.addData(SKTexture(imageNamed: "TV2"), key: "TV2")
        PreloadData.addData(SKTexture(imageNamed: "TV3"), key: "TV3")
        PreloadData.addData(SKTexture(imageNamed: "TV4"), key: "TV4")

        
        //frame Animation Perso
        for var index = 2; index < 22; index++ {
            PreloadData.addData(SKTexture(imageNamed: "frame\(index)"), key: "frame\(index)")
        }
        for var index = 1; index < 12; index++ {
            PreloadData.addData(SKTexture(imageNamed: "course\(index)"), key: "course\(index)")
        }
        for var index = 1; index < 11; index++ {
            PreloadData.addData(SKTexture(imageNamed: "mere\(index)"), key: "mere\(index)")
        }
        for var index = 1; index < 11; index++ {
            PreloadData.addData(SKTexture(imageNamed: "anim\(index)"), key: "anim\(index)")
        }
        for var index = 1; index < 9; index++ {
            PreloadData.addData(SKTexture(imageNamed: "suiveur\(index)"), key: "suiveur\(index)")
        }
        for var index = 1; index < 5; index++ {
            PreloadData.addData(SKTexture(imageNamed: "animcabinet\(index)"), key: "animcabinet\(index)")            
        }
        for var index = 1; index < 10; index++ {
            PreloadData.addData(SKTexture(imageNamed: "rframe\(index)"), key: "rframe\(index)")
        }
        for var index = 1; index < 9; index++ {
            PreloadData.addData(SKTexture(imageNamed: "frag\(index)"), key: "frag\(index)")
        }
        for var index = 1; index < 9; index++ {
            PreloadData.addData(SKTexture(imageNamed: "kill\(index)"), key: "kill\(index)")
        }
        for var index = 1; index < 12; index++ {
            PreloadData.addData(SKTexture(imageNamed: "tue\(index)"), key: "tue\(index)")
        }
        
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.loadData()
        srand(UInt32(time(nil)))
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

