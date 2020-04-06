//
//  Date.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/4/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation

extension Date {
    static func getTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeStamp: String = dateFormatter.string(from: Date())
        return timeStamp
    }

}
