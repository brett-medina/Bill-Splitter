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

class ViewController: UIViewController {
    
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func touchLogin(_ sender: UIButton) {

        handleLogin()
    }
    
    @IBAction func touchSignUp(_ sender: UIButton) {
    }
    
    func handleLogin() {
        guard let email = emailAddressField.text else {return}
        guard let pass = passwordField.text else {return}
        print("\(email)")
        print("\(pass)")
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("user created!")
            } else {
                print("Error creating user: \(error!.localizedDescription)")
            }
       }
        performSegue(withIdentifier: "login", sender: self)
    }
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

