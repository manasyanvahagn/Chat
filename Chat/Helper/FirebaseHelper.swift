//
//  FirestoreHelper.swift
//  Chat
//
//  Created by Vahagn Manasyan on 4/18/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FirebaseHelper{
    var ref: DatabaseReference!
    var auth: Auth!
    
    func setUser(userData: User, userID: String) {
        ref = Database.database().reference()
        ref.child("users").child(userID).setValue(userData.dictionary) { (error, ref) in
            if let error = error {
                print(error)
            }
        }
    }
    func addGroup (_ groupName: String?,_ groupData: Group) {
        guard let groupName = groupName else {return}
        ref = Database.database().reference()
        ref.child("groups").child(groupName).setValue(groupData.dictionary) {
            (error, ref) in
            if let error = error {
                print(error)
            }
        }
    }
    
}

