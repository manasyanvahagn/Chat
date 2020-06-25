//
//  MessageTableViewCell.swift
//  Chat
//
//  Created by Vahagn Manasyan on 6/2/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit

class CurrentUserMessageTableViewCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var timeStampLabel: UILabel!
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.87
            frame.size.width = newWidth
            frame.origin.x += 50

            super.frame = frame

        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
    }
}
