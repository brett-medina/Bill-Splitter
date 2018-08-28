//
//  SignUpViewController.swift
//  Bill Splitter
//
//  Created by Brett Medina on 8/24/18.
//  Copyright © 2018 Brett Medina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
        self.clearTextFields()
    }
    
    @IBAction func touchContinue(_ sender: UIButton) {
        handleLogin()
    }
    
    func handleLogin() {
        guard let name = nameField.text else {return}
        guard let email = emailField.text else {return}
        guard let pass = passwordField.text else {return}
        guard let userName = userNameField.text else {return}
        guard let phoneNumber = phoneNumberField.text else {return}
        
        // FirebaseAuth creating a user
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("user created!")
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                // FirebaseAuth displayName will be username from FirebaseDatabase
                changeRequest?.displayName = userName
                changeRequest?.commitChanges() { error in
                    if error == nil {
                        print("User display name changed!")
                    }
                }
                
                // Account class will handle updating FirebaseDatabase
                let person = Account()
                person.updateInfo(name: name, username: userName, phoneNumber: phoneNumber, emailAddress: email)
                self.clearTextFields()
                self.performSegue(withIdentifier: "toDivideView", sender: self)
            } else {
                print("Error creating user: \(error!.localizedDescription)")
            }
        }
        
    }
    
    override func viewDidLoad() {
        // Hide keyoard on UIView tap
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        // Hide keyboard on return press
        userNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        nameField.resignFirstResponder()
        phoneNumberField.resignFirstResponder()
        return true
    }

    func clearTextFields() {
        self.userNameField.text = ""
        self.emailField.text = ""
        self.passwordField.text = ""
        self.nameField.text = ""
        self.phoneNumberField.text = ""
    }

}
