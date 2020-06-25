//
//  OtherUsersMessageTableViewCell.swift
//  Chat
//
//  Created by Vahagn Manasyan on 6/23/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit

class OtherUsersMessageTableViewCell: UITableViewCell {
    @IBOutlet var messageTextLabel: UILabel!
    @IBOutlet var timeStampLabel: UILabel!
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.87
            frame.size.width = newWidth
            frame.origin.x += 10

            super.frame = frame

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
}
