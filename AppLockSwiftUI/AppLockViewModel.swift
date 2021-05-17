//
//  AppLockViewModel.swift
//  AppLockSwiftUI
//
//  Created by APPLE on 2021/05/17.
//

import Foundation
import LocalAuthentication

class AppLockViewModel: ObservableObject {
    @Published var isAppLockEnabled: Bool = false
    @Published var isAppUnlocked: Bool = false
    
    func enableAppLock() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
        self.isAppLockEnabled = true
    }
    
    func disableAppLock() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
        self.isAppLockEnabled = false
    }
    
    func getAppLockState() {
        isAppLockEnabled = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
    }
    
    func checkIfBiometricAvailable() -> Bool {
        var error: NSError?
        let laContext = LAContext()
        let isBiometricAvailable = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error {
            print(error.localizedDescription)
        }
        return isBiometricAvailable
    }
    
    func appLockStateChange(appLockState: Bool) {
        let laContext = LAContext()
        if checkIfBiometricAvailable() {
            var reason = ""
            if appLockState {
                reason = "Provide TouchID / FaceID to enable App Lock"
            } else {
                reason = "Provide TouchID / FaceID to disable App Lock"
            }
            laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
                if success {
                    if appLockState {
                        DispatchQueue.main.async {
                            self.enableAppLock()
                            self.isAppUnlocked = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.disableAppLock()
                            self.isAppUnlocked = true
                        }
                    }
                } else {
                    if let error = error {
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    func appLockValidation() {
        let laContext = LAContext()
        if checkIfBiometricAvailable() {
            let reason = "Enable App Lock"
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.isAppUnlocked = true
                    }
                } else {
                    if let error = error {
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}

enum UserDefaultsKeys: String {
    case isAppLockEnabled
}
