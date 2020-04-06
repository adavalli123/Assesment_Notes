//
//  AppDelegate_Firebase.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/4/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation
import Firebase

extension AppDelegate {
    struct DataBase {
        static func configureSettings() {
            let settings = FirestoreSettings()
            settings.isPersistenceEnabled = true

            // Enable offline data persistence
            let db = Firestore.firestore()
            db.settings = settings
        }
    }
}
