//
//  Message.swift
//  Hallo
//
//  Created by Carina Boo on 9/27/17.
//  Copyright © 2017 Carina Boo. All rights reserved.
//

import Parse
import UIKit

class Message: PFObject, PFSubclassing {
    @NSManaged var text: String?
    @NSManaged var user: PFUser?
    
    class func parseClassName() -> String {
        return "Message"
    }
}

