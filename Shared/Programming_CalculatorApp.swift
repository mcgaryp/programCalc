//
//  Programming_CalculatorApp.swift
//  Shared
//
//  Created by Porter McGary on 3/17/21.
//

import SwiftUI

@main
struct Programming_CalculatorApp: App {
    // scenePhase is a way of tracking the state of the current state
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        // configure library
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("Active")
            case .inactive:
                print("Inactive")
            case .background:
                print("Background")
            @unknown default:
                // if something is happening to go into the phase this is were you would need to apply
                print("Something new added by apple")
            }
        }
    }
}


