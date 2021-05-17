//
//  AppHomeView.swift
//  AppLockSwiftUI
//
//  Created by APPLE on 2021/05/17.
//

import SwiftUI
import Combine

struct AppHomeView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $appLockVM.isAppLockEnabled, label: {
                    Text("App Lock")
                })
                .onChange(of: appLockVM.isAppLockEnabled, perform: { value in
                    appLockVM.appLockStateChange(appLockState: value)
                })
            }
            .navigationTitle("App Home")
        }
    }
}
