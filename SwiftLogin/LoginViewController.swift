//
//  LoginViewController.swift
//  SwiftLogin
//
//  Created by Laura Kirby on 5/19/16.
//  Copyright © 2016 LK. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!

    @IBOutlet weak var passwordTxt: UITextField!

    @IBAction func signInTapped(sender: UIButton) {
        // Authentication code
    }

    override func viewDidLoad() {
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
