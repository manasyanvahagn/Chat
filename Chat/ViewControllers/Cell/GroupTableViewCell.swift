//
//  GroupCellTableViewCell.swift
//  Chat
//
//  Created by Vahagn Manasyan on 5/18/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    @IBOutlet weak var groupNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(groupName: String) {
        groupNameLabel.text = groupName
    }
}
