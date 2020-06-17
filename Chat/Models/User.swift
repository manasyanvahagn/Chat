//
//  User.swift
//  Chat
//
//  Created by Vahagn Manasyan on 4/17/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import Foundation

struct User {
    let firstName: String
    let lastName: String
    let age: UInt8
    let email: String
    let password: String
    
    var dictionary: [String: Any] {
        return [ "firstName": firstName,
                 "lastName": lastName,
                 "age": age,
                 "email": email,
                 "password": password ]
    }
}
