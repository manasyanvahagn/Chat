//
//  MessageTableViewCell.swift
//  Chat
//
//  Created by Vahagn Manasyan on 6/2/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
