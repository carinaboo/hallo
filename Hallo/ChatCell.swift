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
            if let user = try! message.user?.fetchIfNeeded() {
                // Note: If you're not on Parse v1.15, this will crash on fetchIfNeeded() when you post a message.
                // v1.14 had a bug where message.user is returned as a dictionary instead of a PFUser.
                // To update `pod update`, delete your Podfile.lock, and run `pod install`.
                userLabel.text = user.username
                userLabel.isHidden = false
            } else {
                userLabel.isHidden = true
            }
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
