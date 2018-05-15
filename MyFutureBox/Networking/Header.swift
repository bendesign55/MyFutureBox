//
//  Header.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 24/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import Foundation
import KeychainSwift

struct Header {
    
    enum HeaderType {
        case unauthenticated
        case tokenJson
    }
    
    static let contentType = "Content-Type"
    static let authorization = "Authorization"
    static let bearer = "Bearer"
    static let appId = "AppId"
    static let appVersion = "appVersion"
    static let apiVerson = "apiVersion"
    static let applicationJson = "application/json"
    
    static let appIdNumber = "8cb2237d0679ca88db6464"
    static let appVersionNumber = "4.0.0"
    static let apiVersionNumber = "3.0.0"
    
    static func header (_ type: HeaderType) -> [String: String] {
        
        switch type {
        case .unauthenticated:
            return [self.appId: self.appIdNumber,
                    self.contentType: self.applicationJson,
                    self.appVersion: self.appVersionNumber,
                    self.apiVerson: self.apiVersionNumber]
        case .tokenJson:
            guard let token = KeychainSwift.getAuthToken() else { return ["": ""] }
            return [self.appId: self.appIdNumber,
                self.contentType: applicationJson,
                self.appVersion: self.appVersionNumber,
                self.apiVerson: self.apiVersionNumber,
                self.authorization: "\(self.bearer) \(token)"]
        }
        
    }
}
