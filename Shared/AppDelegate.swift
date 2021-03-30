//
//  AppDelegate.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/29/21.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
//        print("Hello app delegate")
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let config = UISceneConfiguration(name: "My Scene Deletate", sessionRole: connectingSceneSession.role)
        
        config.delegateClass = SceneDelegate.self
        
        return config
    }
}
