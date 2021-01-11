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
            ContentView().environmentObject(listManager).onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
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


extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
