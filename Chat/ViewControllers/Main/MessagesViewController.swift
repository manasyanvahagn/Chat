//
//  GroupMessagesViewController.swift
//  Chat
//
//  Created by Vahagn Manasyan on 6/3/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MessagesViewController: UIViewController {
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var sendMessageTextField: UITextField!
    let timeStampHelper = TimeStampHelper()
    var ref: DatabaseReference!
    var auth: Auth!
    var groupName: String?
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func send(_ sender: Any) {
        sendMessage()
        sendMessageTextField.text = ""
    }
    
    func setup() {
        navigationItem.title = groupName
        fetchMessages()
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messagesTableView.backgroundColor = #colorLiteral(red: 0.1960602105, green: 0.1960886121, blue: 0.1960505545, alpha: 1)
        messagesTableView.allowsSelection = false
    }
    
    func sendMessage() {
        ref = Database.database().reference().child("groups")
        auth = Auth.auth()
        guard
            let groupName = groupName,
            let messageText = sendMessageTextField.text,
            let senderID = auth.currentUser?.uid else {return}
        
        let message = Message(messageText: messageText, senderID: senderID, timeStampString: timeStampHelper.getTimeStamp())
        ref.child(groupName).child("messages").child(message.messageText).setValue(message.dict)
        fetchMessages()
    }
    
    
    func fetchMessages() {
        guard let groupName = groupName else {return}
        ref = Database.database().reference().child("groups").child(groupName).child("messages")
        ref.observe(.value) { (snapshot) in
            self.messages = []
            guard let messagesData = snapshot.value as? Dictionary<String, Any> else {return}
            
            for (messageText, messageInfo) in messagesData {
                if let messageInfo = messageInfo as? Dictionary<String, String> {
                    let message = Message(messageText: messageText, senderID: messageInfo["senderID"]!, timeStampString: messageInfo["timeStamp"]!)
                    self.messages.append(message)
                }
            }
            self.messages.sort { (message1, message2) -> Bool in
                guard
                    let msg1 = self.timeStampHelper.convertTimeStamp(message1.timeStampString),
                    let msg2 = self.timeStampHelper.convertTimeStamp(message2.timeStampString) else {return false}
                return msg1 < msg2
            }
            self.messagesTableView.reloadData()
            self.messagesTableView.scrollToRow(at: IndexPath(item: self.messages.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
}

extension MessagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let messageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MessagesTableViewCell", for: indexPath) as?
            MessagesTableViewCell else {return UITableViewCell()}
        messageTableViewCell.messageLabel.text = messages[indexPath.row].messageText
        return messageTableViewCell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}

extension MessagesViewController: UITableViewDelegate {
    
}


