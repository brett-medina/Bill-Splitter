//
//  DivideViewController.swift
//  Bill Splitter
//
//  Created by Brett Medina on 8/26/18.
//  Copyright © 2018 Brett Medina. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

var numFriends: Int?
var result: String?

class DivideViewController: UIViewController, UITextFieldDelegate {
    
    var totalAmount: Double?
    var ready = false
    
    @IBOutlet weak var totalAmountOutlet: UITextField!
    @IBOutlet weak var numFriendsOutlet: UITextField!
    @IBOutlet weak var resultOutlet: UILabel!
    
    @IBAction func logoutButton(_ sender: UIButton) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "toLogin", sender: self)
        self.totalAmountOutlet.text = ""
        self.numFriendsOutlet.text = ""
        resultOutlet.text = "$0.00"
        ready = false
    }
    
    @IBAction func touchContinue(_ sender: UIButton) {
        if ready {
            performSegue(withIdentifier: "toMessagesView", sender: self)
            totalAmountOutlet.text = ""
            numFriendsOutlet.text = ""
            resultOutlet.text = ""
        }
    }
    
    
    override func viewDidLoad() {
        self.totalAmountOutlet.text = ""
        self.numFriendsOutlet.text = ""
        hideKeyboardOnViewPress()
        // Anytime text fields are updated, check if you can update the result text label
        totalAmountOutlet.addTarget(self, action: #selector(DivideViewController.calculate), for: UIControlEvents.editingChanged)
        numFriendsOutlet.addTarget(self, action: #selector(DivideViewController.calculate), for: UIControlEvents.editingChanged)
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    
    @objc func calculate() {
        if (totalAmountOutlet.text != nil) {
            totalAmount = Double(totalAmountOutlet.text!)
        }
        if (numFriendsOutlet.text != nil) {
            numFriends = Int(numFriendsOutlet.text!)
        }
        showResult()
    }
    
    func showResult() {
        if (totalAmount != nil && numFriends != nil) {
            let resultDouble = totalAmount! / Double(numFriends!)
            result = String(format: "%.02f", resultDouble)
            resultOutlet.text = "$\(result!)"
            ready = true
        }
    }
    
    func hideKeyboardOnViewPress() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        totalAmountOutlet.delegate = self
        numFriendsOutlet.delegate = self
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
