//
//  ChatCell.swift
//  Hallo
//
//  Created by Carina Boo on 9/27/17.
//  Copyright © 2017 Carina Boo. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    var message: Message! {
        didSet {
            messageLabel.text = message.text
            if var user = message.user {
                user = try! user.fetchIfNeeded()
                userLabel.text = user.username ?? ""
            }
//            if let user = try! message.user?.fetchIfNeeded() {
//                userLabel.text = user.username
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
