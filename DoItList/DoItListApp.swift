//
//  DoItListApp.swift
//  DoItList
//
//  Created by João Victor Ipirajá de Alencar on 08/01/21.
//

import SwiftUI

@main
struct DoItListApp: App {
    var listManager = ListManager()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(listManager)
        }
    }
}
