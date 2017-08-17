//
//  LoginViewController.swift
//  Tinder Clone
//
//  Created by Alex Wong on 8/17/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    var signUpMode = false
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginSignUpButton: UIButton!
    @IBOutlet weak var changeLoginSignupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.isHidden = true
    }

    // MARK: - IBActions
    
    @IBAction func loginSignUpTapped(_ sender: Any) {
        
        if signUpMode{
            // sign up
            
            let user = PFUser()
            
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            
            user.signUpInBackground(block: { (success, error) in
                if error != nil {
                    
                    var errorMessage = "Sign Up failed - Try Again"
                    
                    if let newError = error as? NSError {
                        
                        if let detailError = newError.userInfo["error"] as? String{
                            
                            errorMessage = detailError
                            
                            
                        }
                        
                    }
                    
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = errorMessage
                } else {
                    
                    print("Sign up successful")
                    
                    
                }
            })
            
            
        } else {
            
            // login
            
            if let username = usernameTextField.text {
                if let password = passwordTextField.text {
                    
                    PFUser.logInWithUsername(inBackground: username, password: password, block: { (user, error) in
                        if error != nil {
                            
                            var errorMessage = "Log in failed - Try Again"
                            
                            if let newError = error as? NSError {
                                
                                if let detailError = newError.userInfo["error"] as? String{
                                    
                                    errorMessage = detailError
                                    
                                    
                                }
                                
                            }
                            
                            self.errorLabel.isHidden = false
                            self.errorLabel.text = errorMessage
                        } else {
                            
                            print("Login successful")
                            
                            
                        }
                    })
                }
                
                
            }
            
           
            
            
        }
        
    }
    
    @IBAction func changeLogInSignUpTapped(_ sender: Any) {
        
        if signUpMode {
            
            loginSignUpButton.setTitle("Log In", for: .normal)
            changeLoginSignupButton.setTitle("Sign Up", for: .normal)
            signUpMode = false
            
        } else {
            
            
            loginSignUpButton.setTitle("Sign Up", for: .normal)
            changeLoginSignupButton.setTitle("Log In", for: .normal)
            signUpMode = true
        }
        
        
        
    }
}
