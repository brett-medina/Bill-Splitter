//
//  SignUpViewController.swift
//  Bill Splitter
//
//  Created by Brett Medina on 8/24/18.
//  Copyright © 2018 Brett Medina. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {


    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func touchContinue(_ sender: UIButton) {
        
        
        // TODO: push this data onto Firebase
        handleLogin()
        performSegue(withIdentifier: "paypalSetup", sender: self)
    }
    
    func handleLogin() {
        guard let email = emailField.text else {return}
        guard let pass = passwordField.text else {return}
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("user created!")
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
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
