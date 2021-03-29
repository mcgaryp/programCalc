//
//  SceneDelegate.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/29/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let contentView = ContentView()
        
//        print("Connecting Scene")
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = OrientationLockedController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
