//
//  LoginViewController.swift
//  Chat
//
//  Created by Vahagn Manasyan on 4/14/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    let auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Actions
    @IBAction func loginTapped(_ sender: UIButton) {
        login()
    }
    
    // MARK: Methods
    
    func login() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {
                let errorMessage = "Not all fields are filled"
                showErrorAlert(errorMessage)
                return
        }
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.showErrorAlert(error.localizedDescription)
            } else {
                self.turnToGroupsPage()
            }
        }
    }
    func turnToGroupsPage() {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let groupsViewController = storyBoard.instantiateViewController(withIdentifier: "GroupsViewController") as! GroupsViewController
        self.navigationController?.pushViewController(groupsViewController, animated: true)
    }
    
    
    func showErrorAlert(_ errorMessage: String?) {
        guard let errorMessage = errorMessage else {return}
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func setup() {
        loginButton.layer.cornerRadius = 0.05 * loginButton.bounds.size.width
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .done
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
