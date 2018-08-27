//
//  MessagesViewController.swift
//  Bill Splitter
//
//  Created by Brett Medina on 8/27/18.
//  Copyright © 2018 Brett Medina. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var namesTextField: UITextField!
    var total: Int = 0
    
    @IBAction func touchAddButton(_ sender: UIButton) {
        guard let name = namesTextField.text else {return}
        // don't enter more users than previously specified
        if total <= 0 {
            return
        }
        namesLabel.text = namesLabel.text! + name + "\n"
        namesTextField.text = ""
        total = total - 1
    }
    
    @IBAction func touchBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        namesLabel.text = ""
        namesTextField.text = ""
    }
    
    override func viewDidLoad() {
        if numFriends != nil {
            total = numFriends!
        }
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
