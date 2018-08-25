//
//  SignUpViewController.swift
//  Bill Splitter
//
//  Created by Brett Medina on 8/24/18.
//  Copyright © 2018 Brett Medina. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameOutlet: UITextField!
    @IBOutlet weak var lastNameOutlet: UITextField!
    @IBOutlet weak var emailAddressOutlet: UITextField!
    @IBOutlet weak var reenterEmailAddressOutlet: UITextField!
    @IBOutlet weak var newPasswordOutlet: UITextField!
    
    
    @IBAction func touchContinue(_ sender: UIButton) {
        if firstNameOutlet.text != nil && lastNameOutlet != nil && emailAddressOutlet.text != nil
            && reenterEmailAddressOutlet.text != nil && newPasswordOutlet.text != nil {
            let firstName = firstNameOutlet.text!
            let lastName = lastNameOutlet.text!
            
            if emailAddressOutlet.text! == reenterEmailAddressOutlet.text {
                let emailAddress = emailAddressOutlet.text!
            }
            let password = newPasswordOutlet.text!
        }
        
        // TODO: push this data onto Firebase
        
        
        performSegue(withIdentifier: "paypalSetup", sender: self)
    }
    override func viewDidLoad() {
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
