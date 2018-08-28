//
//  ViewController.swift
//  Bill Splitter
//
//  Created by Brett Medina on 8/24/18.
//  Copyright © 2018 Brett Medina. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var invalidLoginLabel: UILabel!
    
    @IBAction func touchLogin(_ sender: UIButton) {
        handleLogin()
    }
    
    @IBAction func touchSignUp(_ sender: UIButton) {
        performSegue(withIdentifier: "createNewAccount", sender: self)
        emailAddressField.text = ""
        passwordField.text = ""
        invalidLoginLabel.text = ""
    }
    
    override func viewDidLoad() {
        hideKeyboardOnViewPress()
        // caches login. auto login if already logged in
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "login", sender: self)
        }
        super.viewDidLoad()
    }
    
    func hideKeyboardOnViewPress() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        emailAddressField.delegate = self
        passwordField.delegate = self
    }
    
    func handleLogin() {
        guard let email = emailAddressField.text else {return}
        guard let pass = passwordField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if (error == nil && user != nil) {
                self.performSegue(withIdentifier: "login", sender: self)
                self.invalidLoginLabel.text = ""
            } else {
                self.invalidLoginLabel.text = "Invalid email and/or password"
            }
            self.emailAddressField.text = ""
            self.passwordField.text = ""
        }
    }

    // hide keyboard on return press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailAddressField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }

}

