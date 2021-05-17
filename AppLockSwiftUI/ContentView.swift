//
//  ContentView.swift
//  AppLockSwiftUI
//
//  Created by APPLE on 2021/05/17.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
    var body: some View {
        ZStack {
            if !appLockVM.isAppLockEnabled || appLockVM.isAppUnlocked {
                AppHomeView()
                    .environmentObject(appLockVM)
            } else {
                AppLockView()
                    .environmentObject(appLockVM)
            }
        }
        .onAppear {
            if appLockVM.isAppLockEnabled {
                appLockVM.appLockValidation()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
