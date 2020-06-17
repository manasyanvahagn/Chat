//
//  SignUpViewController.swift
//  Chat
//
//  Created by Vahagn Manasyan on 4/14/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    let firebaseHelper = FirebaseHelper()
    let validationHelper = ValidationHelper()
    let auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Actions
    
    @IBAction func signUp(_ sender: UIButton) {
        if let errorMessage = errorMessage() {
            showErrorAlert(errorMessage)
        } else {
            guard let firstName = firstNameTextField.text,
                let lastName = lastNameTextField.text,
                let stringAge = ageTextField.text,
                let email = emailTextField.text,
                let password = passwordTextField.text,
                let age = UInt8(stringAge) else {return}
            let user = User(firstName: firstName, lastName: lastName, age: age, email: email, password: password)
            auth.createUser(withEmail: user.email, password: user.password) { (result, error) in
                if let error = error {
                    self.showErrorAlert(error.localizedDescription)
                } else {
                    if let result = result {
                        self.firebaseHelper.setUser(userData: user, userID: result.user.uid)
                    }
                }
            }
        }
    }
    
    // MARK: Methods
    
    func setup() {
        signUpButton.layer.cornerRadius = 0.05 * signUpButton.bounds.size.width
    }
    
    
    // Checking is filled data correct
    
    func isTextFieldsEmpty() -> Bool {
        if firstNameTextField.text == "" ||
            lastNameTextField.text == "" ||
            ageTextField.text == "" ||
            emailTextField.text == "" ||
            passwordTextField.text == "" ||
            repeatPasswordTextField.text == "" {
            return true
        }
            return false
    }
    
    func errorMessage() -> String? {
        var errorMessage: String?
        
        if isTextFieldsEmpty() {
            errorMessage = "Not all fields are filled"
        } else if !validationHelper.isAgeCorrect(ageTextField) {
            errorMessage = "Incorrect age"
        } else if !validationHelper.isEmailValid(emailTextField) {
            errorMessage = "Incorrect email"
        } else if !validationHelper.isPasswordsMatch(passwordTextField, repeatPasswordTextField) {
            errorMessage = "Passwords are not match"
        } else if validationHelper.isPasswordValid(passwordTextField) {
            errorMessage = "Incorrect Password"
        }
        return errorMessage
    }
    
    func showErrorAlert(_ errorMessage: String?) {
        guard let errorMessage = errorMessage else {return}
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}


