//
//  AppLockSwiftUIApp.swift
//  AppLockSwiftUI
//
//  Created by APPLE on 2021/05/17.
//

import SwiftUI

@main
struct AppLockSwiftUIApp: App {
    @StateObject var appLockVM = AppLockViewModel()
    @Environment(\.scenePhase) var scenePhase
    
    @State var blurRadius: CGFloat = 0
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appLockVM)
                .blur(radius: blurRadius)
                .onChange(of: scenePhase, perform: { value in
                    switch value {
                    case .active:
                        blurRadius = 0
                    case .background:
                        appLockVM.isAppUnlocked = false
                    case .inactive:
                        blurRadius = 5
                    @unknown default:
                        print("unknown")
                    }
                })
        }
    }
}
