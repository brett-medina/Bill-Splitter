//
//  ViewController.swift
//  Bill Splitter
//
//  Created by Brett Medina on 8/24/18.
//  Copyright © 2018 Brett Medina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func touchLogin(_ sender: UIButton) {
        if emailAddress.text != nil && password.text != nil {
            //TODO: Check with Firebase for correct user name and password
            let email = emailAddress.text
            let password = emailAddress.text
            
            // Go to Let's split the bill view
            performSegue(withIdentifier: "login", sender: self)
        }
        // TODO: push email and password into an engine class into Firebase
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

