//
//  SignupVC.swift
//  Covid-19Tracker
//
//  Created by Sarath Sasi on 09/04/20.
//  Copyright © 2020 XCoders. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import TransitionButton

class SignupVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitBut: TransitionButton!
    //Sign Up Action for email
    
    override func viewDidLoad() {
        emailTextField.delegate = self as? UITextFieldDelegate
        passwordTextField.delegate = self as? UITextFieldDelegate
    }
    
    @IBAction func createAccountAction(_ sender: AnyObject) {
        
        submitBut.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.submitBut.stopAnimation(animationStyle: .expand, completion: {
                    if self.emailTextField.text == "" {
                        let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    } else {
                        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                            
                            if error == nil {
                                print("You have successfully signed up")
                                //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                                self.emailTextField.text = ""
                                    self.passwordTextField.text = ""
                                                              
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginHome")
                                self.present(vc!, animated: true, completion: nil)
                                
                            } else {
                                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                                
                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alertController.addAction(defaultAction)
                                
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                    }
                })
            })
        })
    }
}

