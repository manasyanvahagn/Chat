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
    let firebaseHelper = FirebaseHelper()
    var ref: DatabaseReference!
    var auth: Auth!
    var groupName: String?
    var messages: [Message] = []
    var userData: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func send(_ sender: Any) {
        if sendMessageTextField.text != "" {
            sendMessage()
            sendMessageTextField.text = ""
        }
    }
    
    func setup() {
        navigationItem.title = groupName
        fetchMessages()
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messagesTableView.backgroundColor = #colorLiteral(red: 0.1960602105, green: 0.1960886121, blue: 0.1960505545, alpha: 1)
        messagesTableView.allowsSelection = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
            self.messagesTableView.scrollToRow(at: IndexPath(item: self.messages.count - 1, section: 0), at: .bottom, animated: false)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension MessagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userID = Auth.auth().currentUser?.uid else {return UITableViewCell()}
        if userID == messages[indexPath.row].senderID {
            guard let messageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CurrentUserMessageTableViewCell", for: indexPath) as?
                CurrentUserMessageTableViewCell else {return UITableViewCell()}
            messageTableViewCell.messageLabel.text = messages[indexPath.row].messageText
            messageTableViewCell.timeStampLabel.text = messages[indexPath.row].timeStampString
            return messageTableViewCell
        } else {
            guard let messageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OtherUsersMessageTableViewCell", for: indexPath) as?
                OtherUsersMessageTableViewCell else {return UITableViewCell()}
            messageTableViewCell.messageTextLabel.text = messages[indexPath.row].messageText
            messageTableViewCell.timeStampLabel.text = messages[indexPath.row].timeStampString
            return messageTableViewCell
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8
        
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
}

extension MessagesViewController: UITableViewDelegate {
    
}


