//
//  ChatViewController.swift
//  Simple Chat
//
//  Created by Cassy on 4/16/20.
//  Copyright © 2020 Cassy. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    var messages: [Message] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = C.appName
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: C.cellNibName, bundle: nil), forCellReuseIdentifier: C.cellIdentifier)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let message = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(C.FStore.collectionName).addDocument(data: [C.FStore.senderField: messageSender,
                                                                      C.FStore.bodyField: message
            ]) { (error) in
                if let e = error {
                    //print("issue daving messages to firestore")
                }
            }
        }
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
          
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = messages[indexPath.row].body
        return cell
    }
}

