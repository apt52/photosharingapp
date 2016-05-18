//
//  ViewController.swift
//  photosharing
//
//  Created by Rohan Desai on 5/8/16.
//  Copyright © 2016 rd. All rights reserved.
//

import UIKit

import Parse

class ViewController: UIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title: String, message: String) {
        
        let alert =  UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
        if firstName.text == "" || lastName.text == "" || phoneNumber.text == "" || emailId.text == "" || password.text == "" {
        
            self.displayAlert("Error in form.", message: "Please enter all the details.")
        
        } else {
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var user = PFUser()
            var errorMessage = "Please try again later."
            
            user.username = firstName.text
            user.email = emailId.text
            user.password = password.text
            user["firstName"] = firstName.text
            user["lastName"] = lastName.text
            user["phoneNumber"] = phoneNumber.text
            
            user.signUpInBackgroundWithBlock({ (success, error) in
                if error == nil {
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    self.displayAlert("Success!", message: "User signed up successfully!")
                } else {
                    if let errorString = error?.userInfo["error"] as? String {
                        errorMessage = errorString
                    }
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    self.displayAlert("Signup error", message: errorMessage)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

