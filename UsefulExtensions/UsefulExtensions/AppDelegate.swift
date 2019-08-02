//
//  AppDelegate.swift
//  UsefulExtensions
//
//  Created by Ho, Tsung Wei on 8/1/19.
//  Copyright © 2019 Ho, Tsungwei. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let view = ViewController()
        self.window!.rootViewController = view
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

