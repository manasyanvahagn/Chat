//
//  GroupMessagesViewController.swift
//  Chat
//
//  Created by Vahagn Manasyan on 6/3/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class messagesViewController: UIViewController {
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var sendMessageTextField: UITextField!
    @IBOutlet weak var groupNavigationBarName: UINavigationItem!
    var groupName: String?
    var messages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupNavigationBarName.title = groupName
    }
    
    @IBAction func send(_ sender: Any) {
    }
    
    func setup() {
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
    }
    
    func sendMessage() {
        
    }
    
}

extension messagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let groupMessagesTableViewCell = MessageTableViewCell.dequeueReusableCell(withIdentifier: "messagesTableViewCell", for: indexPath) as? GroupTableViewCell
                   else {return UITableViewCell()}
               groupTableViewCell.set(groupName: groupNames[indexPath.row], lastMessage: "last message")
               return groupTableViewCell
    }
    
    
}

extension messagesViewController: UITableViewDelegate {
    
}


