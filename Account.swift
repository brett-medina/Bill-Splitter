//
//  Account.swift
//  Bill Splitter
//
//  Created by Brett Medina on 8/27/18.
//  Copyright © 2018 Brett Medina. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class Account {
    
    var name: String?
    var username: String?
    var phoneNumber: String?
    var emailAddress: String?
    let userID = Auth.auth().currentUser?.uid
    
    // make sure to call only after account is created through FB Auth
    func updateInfo(name: String, username: String, phoneNumber: String, emailAddress: String) {
        self.name = name
        self.username = username
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        
        databaseRef.child("users/\(userID!)/name").setValue(name)
        databaseRef.child("users/\(userID!)/username").setValue(username)
        databaseRef.child("users/\(userID!)/phoneNumber").setValue(phoneNumber)
        databaseRef.child("users/\(userID!)/emailAddress").setValue(emailAddress)
    }
    
}
