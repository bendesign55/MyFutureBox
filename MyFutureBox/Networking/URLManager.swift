//
//  URLManager.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 23/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import Foundation

struct URLManager {
    
    static let baseURL = "BASE-URL"
    
    static let users = "/users"
    static let login = "/login"
    static let logout = "/logout"
    
    static let investorproduct = "/investorproduct"
    static let thisweek = "/thisweek"
    static let offpayments = "/offpayments"
    
    static func loginURL() -> String {
        return "\(baseURL)\(users)\(login)"
    }
    
    static func logoutURL() -> String {
        return "\(baseURL)\(users)\(logout)"
    }
    
    static func thisweekURL() -> String {
        return "\(baseURL)\(investorproduct)\(thisweek)"
    }

    static func offpaymentsURL() -> String {
        return "\(baseURL)\(offpayments)"
    }
}
