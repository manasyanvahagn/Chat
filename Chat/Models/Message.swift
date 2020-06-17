//
//  Message.swift
//  Chat
//
//  Created by Vahagn Manasyan on 5/13/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import Foundation


struct Message {
    let messageText: String
    let senderID: String
    let timeStampString: String
    
    var dict: [String: String] {
        return
            ["senderID": senderID,
             "timeStamp": timeStampString]
    }
}
