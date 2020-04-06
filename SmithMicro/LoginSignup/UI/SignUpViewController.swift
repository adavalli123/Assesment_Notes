//
//  SignUpViewController.swift
//  SmithMicro
//
//  Created by Varshini Thatiparthi on 4/3/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

enum TextFieldType: Int {
    case email = 10
    case password = 11
}

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var signupButton: UIButton!
    
    var viewModal = LoginSignupViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupUI() {
        emailTextField?.becomeFirstResponder()
        emailTextField?.setBottomBorder()
        passwordTextField?.setBottomBorder()
        
        emailTextField?.tag = TextFieldType.email.rawValue
        passwordTextField?.tag = TextFieldType.password.rawValue
        
        emailTextField?.delegate = self
        passwordTextField?.delegate = self
    }
    
    
    @IBAction func selectedSignup(_ sender: Any) {
        viewModal.delegate = self
        viewModal.userAuthenticationCreateRegisterationAPI()
    }
    
    
    @IBAction func selectedNoThanks(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: LoginSignupViewModalDelegate {
    func updateUsers(_ users: Users) {
        let folderListVC = FolderListViewController()
        folderListVC.user = users
        self.navigationController?.pushViewController(folderListVC, animated: true)
    }
}

extension SignUpViewController: UITextFieldDelegate {
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

private extension SignUpViewController {
    enum Constants {
        static let firstName = "First Name"
        static let lastName = "Last Name"
        static let email = "Email"
        static let password = "Password"
    }
}
