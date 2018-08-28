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
import MessageUI

class MessagesViewController: UIViewController, UITextFieldDelegate, MFMessageComposeViewControllerDelegate {
    
    var displayName : String?
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    var usernameToFullname: [String:String] = [:]
    var phoneNumbers: [String] = []
    var ref:DatabaseReference?
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    var total: Int = 0
    
    @IBAction func touchMessage(_ sender: UIButton) {
        if (MFMessageComposeViewController.canSendText()) {
                ref?.child("users").child(displayName!).observeSingleEvent(of: .value, with: {(snapshot) in
                    let userObject = snapshot.value as? [String: AnyObject]
                    let name = userObject?["name"] as! String
                    
                    let composeVC = MFMessageComposeViewController()
                    composeVC.messageComposeDelegate = self
                    composeVC.recipients = self.phoneNumbers
                    composeVC.body = "Reminder! You owe \(name) $\(result!). Thanks bud!"
                    
                    self.present(composeVC, animated: true, completion: nil)
                })
            
        }
    }
    
    @IBAction func touchAddButton(_ sender: UIButton) {
        guard let username = userNameTextField.text else {return}
        // don't enter more users than previously specified
        if total <= 0 {
            return
        }
        
        // You can' add yourself to the list
        if displayName == username {
            self.userNameTextField.text = ""
            self.errorLabel.text = "You can't add yourself to the list."
            return
        }
        
        ref?.child("users").child(username).observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                // have to create a dict to get value from field
                let userObject = snapshot.value as? [String: AnyObject]
                let name = userObject?["name"] as! String
                let username = userObject?["username"] as! String
                let phoneNumber = userObject?["phoneNumber"] as! String
                self.phoneNumbers.append(phoneNumber)
                self.userNameTextField.text = ""
                self.total = self.total - 1
                self.usernameToFullname[username] = name
                self.updateNames()
                self.errorLabel.text = ""
            } else {
                self.errorLabel.text = "\(username) is not a user."
            }
            })
    }
    
    @IBAction func touchRemove(_ sender: UIButton) {
        guard let username = userNameTextField.text else {return}
        if (usernameToFullname.removeValue(forKey: username) != nil) {
            updateNames()
            self.userNameTextField.text = ""
            self.errorLabel.text = ""
        } else {
            if (username == "") {
                self.errorLabel.text = "Enter a username."
            } else {
            self.errorLabel.text = "\(username) is not a user."
            }
        }
    }
    
    @IBAction func touchBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        phoneNumbers.removeAll()
        usernameToFullname.removeAll()
        namesLabel.text = ""
        userNameTextField.text = ""
        errorLabel.text = ""
    }
    
    override func viewDidLoad() {
        // Set the firebase reference
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        if let user = user {
            displayName = user.displayName
        }
        
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
    
    func updateNames() {
        var temp = ""
        for (_, fullname) in self.usernameToFullname {
            temp += "\(fullname) \n"
        }
        self.namesLabel.text = temp
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
