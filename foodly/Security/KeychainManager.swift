//
//  Keychain.swift
//  foodly
//
//  Created by Sergei Kulagin on 20.12.2022.
//

import Foundation

class KeychainManager {
    
    static let defaults = UserDefaults.standard
    
    static func saveToken(token: String) -> Void {
        defaults.set(token, forKey: "accessToken")
    }
    
    static func getToken() -> String {
        return defaults.string(forKey: "accessToken")!
    }
    
    static func checkToken() -> Bool {
        return UserDefaults.standard.object(forKey: "accessToken") != nil
    }
    
    // only for check
    static func deleteToken() {
        UserDefaults.standard.removePersistentDomain(forName: "accessToken")
    }
}
