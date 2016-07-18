//
//  ReadingsViewController.swift
//  login
//
//  Created by Rohan Murde on 1/2/16.
//  Copyright © 2016 ROHAN. All rights reserved.
//

import UIKit

class ReadingsViewController: UIViewController {

    @IBOutlet weak var att1TextField: UITextField!
    @IBOutlet weak var att2TextField: UITextField!
    @IBOutlet weak var classNameTextField: UITextField!
    
    var att1: Float = 0.0
    var att2: Float = 0.0
    
    @IBAction func logoutAction(sender: AnyObject){
        PFUser.logOut();
        self.loginSetup();
    }
    

    func loginSetup(){
        let vc : AnyObject! = self.storyboard?.instantiateInitialViewController()
        self.presentViewController(vc as! UIViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        NSLog("Inside SignUpViewController....");
        att1TextField.text = "";
        att2TextField.text = "";
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitReadingsPressed(sender: AnyObject) {
      att1 = Float(att1TextField.text!)!
      att2 = Float(att2TextField.text!)!
        
//        let myUrl = NSURL(string: "http://localhost/welcome.php")
        let myUrl = NSURL(string: "http://localhost/insertRecord.php") //Inserts a record in the mySQL database.
        
        let request = NSMutableURLRequest(URL: myUrl!);
        request.HTTPMethod = "POST";
        
        let postString = "att1="+String(att1)+"&att2="+String(att2);
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            
            if error != nil{
                
                print("error=\(error)")
                return
                
            }
            
//            print("*** response=\(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("@@@@ response data = \(responseString!)")
            
            do {
//                print("in do")
                if let jsonResult : NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    
//                  print("JSON data = \(jsonResult)")
                    // Get value by key
                    let attribute1 = jsonResult["className"] as? String
                    print("ClassRecognition = \(attribute1!)")
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.classNameTextField.text =  attribute1!
                    })

                    
                    }
                    
                
            } catch let error as NSError {
//                print("in catch")
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
        
    }
   
}

