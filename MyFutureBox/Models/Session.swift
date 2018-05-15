//
//  Session.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 24/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import Foundation

struct Session: Decodable {
    let bearerToken: String
}

struct LoginSession: Decodable {
    let session: Session
}
