//
//  ViewController.swift
//  Covid-19Tracker
//
//  Created by Sarath Sasi on 07/04/20.
//  Copyright © 2020 XCoders. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import TransitionButton
class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBut: TransitionButton!
    
    override func viewDidLoad() {
        emailTextField.delegate = self as? UITextFieldDelegate
        passwordTextField.delegate = self as? UITextFieldDelegate
    }
    
    
    //Login Action
    @IBAction func loginAction(_ sender: AnyObject) {
        
        loginBut.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.loginBut.stopAnimation(animationStyle: .expand, completion: {
                    
                    if self.emailTextField.text == "" || self.passwordTextField.text == "" {
                        
                        //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
                        
                        let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    } else {
                        
                        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                            
                            if error == nil {
                                
                                //Print into the console if successfully logged in
                                print("You have successfully logged in")
                                self.emailTextField.text = ""
                                self.passwordTextField.text = ""
                                //Go to the HomeViewController if the login is sucessful
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                                self.present(vc!, animated: true, completion: nil)
                                
                            } else {
                                
                                //Tells the user that there is an error and then gets firebase to tell them the error
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

