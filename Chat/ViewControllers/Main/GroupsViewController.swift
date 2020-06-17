//
//  ViewController.swift
//  Chat
//
//  Created by Vahagn Manasyan on 4/14/20.
//  Copyright © 2020 Vahagn Manasyan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class GroupsViewController: UIViewController {
    
    @IBOutlet weak var groupTableView: UITableView!
    let auth = Auth.auth()
    var ref: DatabaseReference!
    let firebaseHelper = FirebaseHelper()
    var groupNames: [String] = []
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: -Actions-
    
    @IBAction func showGroupAddingAlert(_ sender: UIBarButtonItem) {
        showAlert()
    }
    
    
    // MARK: -Methods-
    
    func setup() {
        groupTableView.dataSource = self
        groupTableView.delegate = self
        fetchGroups()
        navigationItem.backBarButtonItem?.tintColor = .red
    }
    
    /// This function add to app group adding alert
    func showAlert() {
        let alert = UIAlertController(title: "Add New Group", message: nil, preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Group Name"
        }
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { (action) in
            guard let user = self.auth.currentUser else {return}
            let groupName = alert.textFields![0].text
            let groupData = Group(creatorUserID: user.uid)
            self.firebaseHelper.addGroup(groupName, groupData)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Getting groups
    
    func fetchGroups() {
        self.ref = Database.database().reference().child("groups")
        self.ref.observe(.value){ (snapshot) in
            self.groupNames = []
            guard let groups = snapshot.value as? Dictionary<String, Any> else {return}
            for (groupName, _) in groups {
                self.groupNames.append(groupName)
            }
            self.groupTableView.reloadData()
        }
    }
    
    
    // Send data to messagesViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MessagesViewController else {return}
        destination.groupName = (sender as? GroupTableViewCell)?.groupNameLabel.text
    }
}


extension GroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let groupTableViewCell = groupTableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell", for: indexPath) as? GroupTableViewCell
            else {return UITableViewCell()}
        groupTableViewCell.set(groupName: groupNames[indexPath.row])
        return groupTableViewCell
    }
}

extension GroupsViewController: UITableViewDelegate {
    
}
