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
        tableView.register(UINib(nibName: C.YourCellNibName, bundle: nil), forCellReuseIdentifier: C.cellIdentifier)
        tableView.register(UINib(nibName: C.TheirCellNibName, bundle: nil), forCellReuseIdentifier: C.TheirCellIdentifier)
        loadChat()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let message = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(C.FStore.collectionName).addDocument(data: [C.FStore.senderField: messageSender,
                                                                      C.FStore.bodyField: message,
                                                                      C.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out:", signOutError)
        }
          
    }
    
    func loadChat() {
        db.collection(C.FStore.collectionName).order(by: C.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let snapshotDocs = querySnapshot?.documents {
                    for doc in snapshotDocs {
                        let data = doc.data()
                        if let messageSender = data[C.FStore.senderField] as? String, let message = data[C.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: message)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        if message.sender == Auth.auth().currentUser?.email {
            let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for: indexPath) as! YourMessageCell
            cell.messageLabel.text = message.body
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for: indexPath)  as! TheirMessageCell
            cell.messageLabel.text = message.body
            return cell
        }
    }
}
