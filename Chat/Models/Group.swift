//
//  Group.swift
//  Chat
//
//  Created by Vahagn Manasyan on 5/21/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//
import Foundation
import FirebaseAuth

struct Group {
    let creatorUserID: String
    var timeStamp: String {
        get {
            let now = Date()
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: now)
            return dateString
        }
    }
    
    var dictionary: [String: Any] {
        return [ "creatorUserID": creatorUserID,
                 "timeStamp": timeStamp ]
    }
}
