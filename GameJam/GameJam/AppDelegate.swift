//
//  AppDelegate.swift
//  GameJam
//
//  Created by Remi Robert on 07/11/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
import SpriteKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func loadData() {
        //background loading
        PreloadData.addData(SKTexture(imageNamed: "begin_house"), key: "begin_house")
        PreloadData.addData(SKTexture(imageNamed: "end_house"), key: "end_house")
        PreloadData.addData(SKTexture(imageNamed: "inter"), key: "inter")
        PreloadData.addData(SKTexture(imageNamed: "ext"), key: "ext")
        
        //item loading
        PreloadData.addData(SKTexture(imageNamed: "cabinet"), key: "cabinet")
        PreloadData.addData(SKTexture(imageNamed: "chair"), key: "chair")
        PreloadData.addData(SKTexture(imageNamed: "table"), key: "table")

        //monster loading
        PreloadData.addData(SKTexture(imageNamed: "monster1"), key: "monster1")
        PreloadData.addData(SKTexture(imageNamed: "monster2"), key: "monster2")
        PreloadData.addData(SKTexture(imageNamed: "monster3"), key: "monster3")
        PreloadData.addData(SKTexture(imageNamed: "monster4"), key: "monster4")
        
        //frame Animation Perso
        for var index = 1; index < 23; index++ {
            PreloadData.addData(SKTexture(imageNamed: "frame\(index)"), key: "frame\(index)")
        }
        
        for var index = 1; index < 12; index++ {
            PreloadData.addData(SKTexture(imageNamed: "course\(index)"), key: "course\(index)")
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

