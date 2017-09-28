//
//  LoginViewController.swift
//  Hallo
//
//  Created by Carina Boo on 9/27/17.
//  Copyright © 2017 Carina Boo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(_ sender: UIButton) {
        // Initialize a user object
        let newUser = PFUser()
        
        // Set user properties
        newUser.username = emailTextField.text
        newUser.email = emailTextField.text
        newUser.password = passwordTextField.text
        
        // Call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                // Show error alert
                let alertController =  UIAlertController(title: "Sign up failed", message: "Might already have been registered", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction) in
                    //
                })
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "LogInToChatSegue", sender: self)
            }
        }
    }
    
    @IBAction func onLogIn(_ sender: UIButton) {
        let username = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                // Show error alert
                let alertController =  UIAlertController(title: "Log in failed", message: "Wrong username/password", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction) in
                    //
                })
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "LogInToChatSegue", sender: self)
            }
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
