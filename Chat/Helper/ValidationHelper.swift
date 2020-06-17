//
//  ValidationHelper.swift
//  Chat
//
//  Created by Vahagn Manasyan on 4/25/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit


class ValidationHelper {
    
    func isEmailValid(_ emailTextField: UITextField ) -> Bool {
        guard let email = emailTextField.text else {return false}
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isPasswordsMatch(_ passwordTextField: UITextField, _ repasswordTextField: UITextField) -> Bool{
        guard let password = passwordTextField.text,
            let repassword = repasswordTextField.text else {return false}
            return password == repassword
        
    }
    
    func isPasswordValid(_ passwordTextField: UITextField) -> Bool {
        guard let password = passwordTextField.text else {return false}
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: password)
        
    }
    
    func isAgeCorrect(_ ageTextField: UITextField) -> Bool{
        guard let stringAge = ageTextField.text else {return false}
        guard UInt8(stringAge) != nil else {return false}
        return true
    }
    
}
