//
//  ViewController.swift
//  GithubExplorer
//
//  Created by Vladyslav Brylinskyi on 05/12/16.
//  Copyright © 2016 BVS. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func refresh(sender: AnyObject) {
        provider.request(.user) { (result) in
            print(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

