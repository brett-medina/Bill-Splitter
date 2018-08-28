//
//  MessagesViewController.swift
//  Bill Splitter
//
//  Created by Brett Medina on 8/27/18.
//  Copyright © 2018 Brett Medina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class MessagesViewController: UIViewController, UITextFieldDelegate {
    
    var usernames: [String] = []
    var phoneNumbers: [String] = []
    var ref:DatabaseReference?
    
    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    var total: Int = 0
    
    @IBAction func touchAddButton(_ sender: UIButton) {
        guard let username = userNameTextField.text else {return}
        // don't enter more users than previously specified
        if total <= 0 {
            return
        }
        
        // Read from database
        ref?.child("users").child(username).observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                // have to create a dict to get value from field
                let userObject = snapshot.value as? [String: AnyObject]
                let name = userObject?["name"] as! String
                let phoneNumber = userObject?["phoneNumber"] as! String
                self.phoneNumbers.append(phoneNumber)
                self.namesLabel.text = self.namesLabel.text! + name + "\n"
                self.userNameTextField.text = ""
                self.total = self.total - 1
            }
            })
    }
    
    @IBAction func touchBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        phoneNumbers.removeAll()
        namesLabel.text = ""
        userNameTextField.text = ""
    }
    
    override func viewDidLoad() {
        // Set the firebase reference
        ref = Database.database().reference()
        if numFriends != nil {
            total = numFriends!
        }
        hideKeyboardOnViewPress()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboardOnViewPress() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        userNameTextField.delegate = self
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
