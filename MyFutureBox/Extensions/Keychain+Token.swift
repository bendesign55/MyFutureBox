//
//  Keychain+Token.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 24/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import Foundation
import KeychainSwift

extension KeychainSwift {
    
    class func setAuthToken(_ token: String) {
        KeychainSwift().set(token, forKey: "authToken")
    }
    
    class func deleteAuthToken() {
        KeychainSwift().delete("authToken")
    }
    
    class func getAuthToken() -> String? {
        guard let refreshToken: String = KeychainSwift().get("authToken") else { return nil }
        return refreshToken
    }
    
    class func getEmail() -> String? {
        guard let email: String = KeychainSwift().get("email") else { return nil }
        return email
    }
    
    
}
