//
//  Sign Up View Controller.swift
//  login
//
//  Created by Rohan Murde on 1/2/16.
//  Copyright © 2016 ROHAN. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var ReEnterPasswordTextField: UITextField!

    let submitSegue = "submitSegue"
    
    @IBAction func submitPressed(sender: AnyObject) {
        //1
        let user = PFUser()
        
        //2
        user.username = userTextField.text
        user.password = passwordTextField.text
        
        //3
        
        if(userTextField.text!.isEmpty || passwordTextField.text!.isEmpty || ReEnterPasswordTextField.text!.isEmpty){
            

            let alertController = UIAlertController(title: "Sign Up Failed", message:
                "All fields are mandatory", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if(passwordTextField.text != ReEnterPasswordTextField.text){
            
            let alertController = UIAlertController(title: "Sign Up Failed", message:
                "Passwords Don't Match !", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else{
            
            user.signUpInBackgroundWithBlock { succeeded, error in
                if (succeeded) {
                    //The registration was successful, go to the wall
                    self.performSegueWithIdentifier(self.submitSegue, sender: nil)
                } else {
                    //Something bad has occurred
                    print("SignUp Error....");
                    
                    let alertController = UIAlertController(title: "Sign Up Failed", message:
                        "Username already exists !", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        print("Inside SignUpViewController....");
        userTextField.text = "";
        passwordTextField.text = "";
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


