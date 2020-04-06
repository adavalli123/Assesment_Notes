//
//  LoginSignupViewModal.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/4/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation
import CodableFirebase
import Firebase

protocol LoginSignupViewModalDelegate {
    func updateUsers(_ users: Users)
}

struct LoginSignupViewModal {
    var delegate: LoginSignupViewModalDelegate?
    var email = ""
    var password = ""
    
    func updateUserDB(_ email: String, password: String) {
        let db = Firestore.firestore().collection("user")
        db.addDocument(data:
            [
                Constants.email: email,
                Constants.password: password,
                Constants.timestamp: Date.getTimestamp(),
                Constants.isLoggedIn: true
            ]
        )
    }
    
    func parseUserDB() {
        let db = Firestore.firestore().collection("user")
        db.whereField("email", isEqualTo: email).getDocuments { [self] (snapshot, error) in
            guard error == nil,
                let documents = snapshot?.documents,
                let document = documents.first
                else { return }
            
            guard let users = FirebaseDecoder.decoder(Users.self, from: document.data()) else { return }
            
            DispatchQueue.main.async {
                self.delegate?.updateUsers(users)
            }
        }
    }
    
    mutating func userAuthenticationSignInAPI() {
        Auth.auth().signIn(withEmail: email, password: password) { [self] (dataResult, error) in
            guard error == nil else { return }
            self.updateUserDB(self.email, password: self.password)
            self.parseUserDB()
        }
    }
    
    mutating func userAuthenticationCreateRegisterationAPI() {
        Auth.auth().createUser(withEmail: email, password: password) { [self] (dataResult, error) in
            guard error == nil else { return }
            self.updateUserDB(self.email, password: self.password)
            self.parseUserDB()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField, passwordTextField: UITextField?) -> Bool {
        switch TextFieldType(rawValue: textField.tag) {
        case .email:
            passwordTextField?.becomeFirstResponder()
        case .password:
            return false
        case .none:
            return false
        }
        
        return true
    }
    
    mutating func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard
            let textFieldString = textField.text,
            let textRange = Range(range, in: textFieldString) else { return false }
        
        let fullString = textFieldString.replacingCharacters(in: textRange, with: string)
        
        switch TextFieldType(rawValue: textField.tag) {
        case .email:
            email = fullString
        case .password:
            password = fullString
        case .none:
            return false
        }
        
        return true
    }
}

private extension LoginSignupViewModal {
    enum Constants {
        static let email = "email"
        static let password = "password"
        static let timestamp = "timestamp"
        static let isLoggedIn = "isLoggedIn"
    }
}
