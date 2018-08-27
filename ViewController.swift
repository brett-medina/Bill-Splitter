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
    
    @IBAction func touchLogin(_ sender: UIButton) {

        performSegue(withIdentifier: "login", sender: self)
    }
    
    @IBAction func touchSignUp(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        // used to hide keyboard on return press
        emailAddressField.delegate = self
        passwordField.delegate = self
        
        // caches login. auto login if already logged in
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "login", sender: self)
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // hide keyboard on return press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailAddressField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }

}

