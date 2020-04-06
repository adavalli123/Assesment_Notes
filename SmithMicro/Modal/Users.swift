//
//  User.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/4/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation

struct Users: Codable {
    let password: String
    let email: String
    let timestamp: String
    let isLoggedIn: Bool
}
