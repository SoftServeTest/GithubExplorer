//
//  LoginViewController.swift
//  GithubExplorer
//
//  Created by Vladyslav Brylinskyi on 05/12/16.
//  Copyright © 2016 BVS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(sender: AnyObject) {
        storage.name = self.loginTextField.text
        storage.password = self.passTextField.text
        
        self.dismiss(animated: true, completion: nil)
    }
}
