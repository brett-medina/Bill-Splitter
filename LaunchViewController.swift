//
//  LaunchViewController.swift
//  Bill Splitter
//
//  Created by Brett Medina on 8/26/18.
//  Copyright © 2018 Brett Medina. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
    }
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "toLoginScreen", sender: self)
    }
    
}
