//
//  ViewController.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/3/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class ViewController: UIViewController {
    @IBOutlet weak var userTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var loginButton: UIButton?
    @IBOutlet weak var signupButton: UIButton?
    
    var viewModal = LoginSignupViewModal()
    
    override func loadView() {
        super.loadView()
        configureSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureSetup() {
        userTextField?.setBottomBorder()
        passwordTextField?.setBottomBorder()
        userTextField?.tag = TextFieldType.email.rawValue
        passwordTextField?.tag = TextFieldType.password.rawValue
        userTextField?.delegate = self
        passwordTextField?.delegate = self
    }
    
    @IBAction func selectedLoggedIn(_ sender: Any) {
        viewModal.delegate = self
        viewModal.userAuthenticationSignInAPI()
    }
    
    @IBAction func selectedSignUp(_ sender: Any) {
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return viewModal.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return viewModal.textFieldShouldReturn(textField, passwordTextField: self.passwordTextField)
    }
}

extension ViewController: LoginSignupViewModalDelegate {
    func updateUsers(_ users: Users) {
        let folderListVC = FolderListViewController()
        folderListVC.user = users
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.pushViewController(folderListVC, animated: true)
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.systemGray.cgColor.copy(alpha: 0.7)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}


