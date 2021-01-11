//
//  DoItListApp.swift
//  DoItList
//
//  Created by João Victor Ipirajá de Alencar on 08/01/21.
//

import SwiftUI

@main
struct DoItListApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var listManager = ListManager()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(listManager)
        }
        .onChange(of: scenePhase){(newScenePhase) in
            switch newScenePhase{
            case .background:
                print("App in background")
            case .inactive:
                print("App is inactive")
            case .active:
                print("App is Active")
                
                print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
            @unknown default:
                print("App is in unknown state.")
            }
        }
    }
}
