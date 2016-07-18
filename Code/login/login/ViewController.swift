//
//  ViewController.swift
//  login
//
//  Created by Rohan Murde on 1/1/16.
//  Copyright © 2016 ROHAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    let ReadingsSegue = "LoginSuccesful"
    let SignUpSegue = "SignUpSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInPressed(sender: AnyObject) {
//        performSegueWithIdentifier(scrollViewWallSegue, sender: nil)
        PFUser.logInWithUsernameInBackground(userTextField.text!, password: passwordTextField.text!) { user, error in
            if user != nil {
                
                print("Login Successful....");
                self.performSegueWithIdentifier(self.ReadingsSegue, sender: nil)
                
            } else {
                print("Login Error....");
                
                let alertController = UIAlertController(title: "Login Failed", message:
                    "Incorrect Credentials !", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signUpPressed(sender: AnyObject) {
        print("SignUp Pressed....");
//     self.performSegueWithIdentifier(self.SignUpSegue, sender: nil)
    }


}

