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

class DivideViewController: UIViewController {
    
    var totalAmount: Double?
    var numFriends: Int?
    var result: Double?
    
    @IBOutlet weak var totalAmountOutlet: UITextField!
    @IBOutlet weak var numFriendsOutlet: UITextField!
    @IBOutlet weak var resultOutlet: UILabel!
    
    @IBAction func logoutButton(_ sender: UIButton) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
        self.totalAmountOutlet.text = ""
        self.numFriendsOutlet.text = ""
    }
    
    override func viewDidLoad() {
        // Anytime text fields are updated, check if you can update the result text label
        totalAmountOutlet.addTarget(self, action: #selector(DivideViewController.calculate), for: UIControlEvents.editingChanged)
        numFriendsOutlet.addTarget(self, action: #selector(DivideViewController.calculate), for: UIControlEvents.editingChanged)
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
            result = totalAmount! / Double(numFriends!)
            resultOutlet.text = String(format: "$%.02f", result!)
        }
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
