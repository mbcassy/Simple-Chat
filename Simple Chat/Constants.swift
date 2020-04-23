//
//  Constants.swift
//  Simple Chat
//
//  Created by Cassy on 4/18/20.
//  Copyright © 2020 Cassy. All rights reserved.
//

import Foundation

struct C {
    static let registerSegue = "RegisterToMessages"
    static let loginSegue = "LoginToMessages"
    static let cellIdentifier = "ReusableCell"
    static let TheirCellIdentifier = "TheirReusableCell"
    static let YourCellNibName = "YourMessageCell"
    static let TheirCellNibName = "TheirMessageCell"
    static let appName = "Simple Chat"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
