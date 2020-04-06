//
//  Folder.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/4/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation

struct Folder: Codable {
    let userID: String?
    let folderName: String
    let folderID: String
    let numberOfNotes: Int
    let timestamp: String
}
