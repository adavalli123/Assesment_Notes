//
//  FirebaseDecoder.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/4/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import CodableFirebase

extension FirebaseDecoder {
    static func decoder<T: Codable>(_ type: T.Type, from data: Any) -> T? {
        do {
            let user = try FirebaseDecoder().decode(type, from: data)
            return user
        } catch let error {
            print(error)
        }
        
        return nil
    }
}
