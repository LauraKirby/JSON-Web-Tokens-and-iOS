//
//  ViewController.swift
//  SwiftLogin
//
//  Created by Laura Kirby on 5/19/16.
//  Copyright © 2016 LK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func logoutTapped(sender: UIButton) {
        self.performSegueWithIdentifier("go_to_login", sender: self)
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        self.performSegueWithIdentifier("go_to_login", sender: self)
    }


}

