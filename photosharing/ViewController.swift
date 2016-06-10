//
//  ViewController.swift
//  photosharing
//
//  Created by Rohan Desai on 5/8/16.
//  Copyright © 2016 rd. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    var signupActive = true
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
 
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidAppear(animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
    }
    
    @IBAction func loginUser(sender: AnyObject) {
        if emailField.text == "" || passwordField.text == "" {
            self.displayAlert("Error in form.", message: "Please enter all the details.")
        } else {
            // Sign In with credentials.
            let email = emailField.text
            let password = passwordField.text
            self.startLoadingIndicator()
            
            FIRAuth.auth()?.signInWithEmail(email!, password: password!) { (user, error) in
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                if let error = error {
                    self.displayAlert("Signin error!",message: error.localizedDescription)
                    return
                }
                print(user)
                self.signedIn(user!)
            }
        }
    }
    
    @IBAction func signUpUser(sender: AnyObject) {
        if emailField.text == "" || passwordField.text == "" {
            self.displayAlert("Error in form.", message: "Please enter all the details.")
        } else {
            // start loading indicator and signup user
            let email = emailField.text
            let password = passwordField.text
            self.startLoadingIndicator()
            FIRAuth.auth()?.createUserWithEmail(email!, password: password!) { (user, error) in
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()

                if let error = error {
                    self.displayAlert("Signup error!", message: error.localizedDescription)
                    return
                }
                self.setDisplayName(user!)
            }

        }
    }
    
    func setDisplayName(user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.componentsSeparatedByString("@")[0]
        changeRequest.commitChangesWithCompletion(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(FIRAuth.auth()?.currentUser)
        }
    }
    
    
    func signedIn(user: FIRUser?) {
        MeasurementHelper.sendLoginEvent()
        
        AppState.sharedInstance.displayName = user?.displayName ?? user?.email
        AppState.sharedInstance.photoUrl = user?.photoURL
        AppState.sharedInstance.signedIn = true
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.NotificationKeys.SignedIn, object: nil, userInfo: nil)
        //performSegueWithIdentifier(Constants.Segues.SignInToFp, sender: nil)
    }
    
    func displayAlert(title: String, message: String) {
        
        let alert =  UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func startLoadingIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    
    
//    @IBAction func signUp(sender: AnyObject) {
//        
//        if emailId.text == "" || password.text == "" {
//        
//            self.displayAlert("Error in form.", message: "Please enter all the details.")
//        
//        } else {
//            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//            activityIndicator.center = self.view.center
//            activityIndicator.hidesWhenStopped = true
//            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//            view.addSubview(activityIndicator)
//            activityIndicator.startAnimating()
//            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    
//            //var errorMessage = "Please try again later."
//            //var user = PFUser()
//            FIRAuth.auth()?.createUserWithEmail(emailId.text!, password: password.text!) { (user, error) in
//                self.activityIndicator.stopAnimating()
//                UIApplication.sharedApplication().endIgnoringInteractionEvents()
//                
//                if let error = error {
//                    print(error)
//                    return
//                }
//                
//                print(user)
//            }
//        }
//
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

