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
    static let cellNibName = "MessageCell"
    static let appName = "Simple Chat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
