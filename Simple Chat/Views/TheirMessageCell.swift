//
//  TheirMessageCell.swift
//  Simple Chat
//
//  Created by Cassy on 4/23/20.
//  Copyright © 2020 Cassy. All rights reserved.
//

import UIKit

class TheirMessageCell: UITableViewCell {

    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
