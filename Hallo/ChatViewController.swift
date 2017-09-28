//
//  ChatViewController.swift
//  Hallo
//
//  Created by Carina Boo on 9/27/17.
//  Copyright © 2017 Carina Boo. All rights reserved.
//

import UIKit
import Parse
//import ParseLiveQuery

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(_ sender: UIButton) {
        let message = Message()
        message.text = chatTextField.text
        message.user = PFUser.current()
//        let message = PFObject(className: "Message")
//        message["text"] = chatTextField.text
//        message["user"] = PFUser.current()
        message.saveInBackground { (isSuccess: Bool, error: Error?) in
            print("Save msg: \(String(describing: self.chatTextField.text)) is successful: \(isSuccess)")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
