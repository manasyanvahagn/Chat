//
//  TimeStampHelper.swift
//  Chat
//
//  Created by Vahagn Manasyan on 6/13/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import Foundation

class TimeStampHelper {
    let formatter = DateFormatter()

    func getTimeStamp() -> String {
        let now = Date()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: now)
        return dateString
    }
    
    func convertTimeStamp (_ timeStampString: String) -> Date? {
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeStamp = formatter.date(from: timeStampString)
        return timeStamp
    }
}
