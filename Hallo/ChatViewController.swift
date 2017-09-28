//
//  ChatViewController.swift
//  Hallo
//
//  Created by Carina Boo on 9/27/17.
//  Copyright © 2017 Carina Boo. All rights reserved.
//

import UIKit
import Parse
import ParseLiveQuery

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    
    var client: ParseLiveQuery.Client!
    var subscription: Subscription<Message>!
    
    var messages: [Message]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let messagesQuery = Message.query()!
            .whereKeyExists("text")
            .includeKey("user")
            .order(byAscending: "createdAt") as! PFQuery<Message>
        
        messagesQuery.findObjectsInBackground { ( results: [Message]?, error: Error?) in
            if let results = results {
                for result in results {
                    self.messages.insert(result, at: 0)
                }
                self.reloadTableData()
            }
        }
        
        client = ParseLiveQuery.Client()
        subscription = client
            .subscribe(messagesQuery)
            .handle(Event.created) { _, message in
                
                DispatchQueue.main.async {
                    self.messages.insert(message, at: 0)
                    self.reloadTableData()
                }
        }
        
        messages = []
        tableView.delegate = self
        tableView.dataSource = self
        self.reloadTableData()
    }
    
    func reloadTableData() {
        self.tableView.reloadData()
    }
    
    @IBAction func onSend(_ sender: UIButton) {
        let message = Message()
        message.text = chatTextField.text
        message.user = PFUser.current()
        
        // If you wanted to create a message not via a PFObject subclass
        //   let message = PFObject(className: "Message")
        //   message["text"] = chatTextField.text
        //   message["user"] = PFUser.current()
        
        message.saveInBackground { (isSuccess: Bool, error: Error?) in
            print("Save message: \(String(describing: self.chatTextField.text)) is successful: \(isSuccess)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.message = messages[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
