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
        let username:NSString = usernameTxt.text!
        let password:NSString = passwordTxt.text!

        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            let alertView = UIAlertController(title: "Login Problem",
                                              message: "Please add username and password." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)

            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)

        } else {

            do {
                let post:NSString = "username=\(username)&password=\(password)"

                NSLog("PostData: %@",post);

                let url:NSURL = NSURL(string:"https://insectlk.herokuapp.com/api/authenticate")!

                let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!

                let postLength:NSString = String( postData.length )

                let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                request.HTTPBody = postData
                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")


                var reponseError: NSError?
                var response: NSURLResponse?

                var urlData: NSData?
                do {
                    urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                } catch let error as NSError {
                    reponseError = error
                    urlData = nil
                }

                if ( urlData != nil ) {
                    let res = response as! NSHTTPURLResponse!;

                    NSLog("Response code: %ld", res.statusCode);

                    if (res.statusCode >= 200 && res.statusCode < 300)
                    {
                        let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!

                        NSLog("Response ==> %@", responseData);

                        //var error: NSError?

                        let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary


                        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger

                        //let jwt = jsonData.valueForKey("token")


                        //[jsonData[@"success"] integerValue];

                        NSLog("Success: %ld", success);

                        if(success == 1)
                        {
                            NSLog("Login SUCCESS");

                            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            prefs.setObject(username, forKey: "USERNAME")
                            prefs.setInteger(1, forKey: "ISLOGGEDIN")
                            prefs.synchronize()

                            self.dismissViewControllerAnimated(true, completion: nil)
                        } else {
                            var error_msg:NSString

                            if jsonData["error_message"] as? NSString != nil {
                                error_msg = jsonData["error_message"] as! NSString
                            } else {
                                error_msg = "Unknown Error"
                            }

                            let alertView = UIAlertController(title: "Login Problem", message: error_msg as String, preferredStyle:.Alert)
                            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                            alertView.addAction(okAction)
                            self.presentViewController(alertView, animated: true, completion: nil)

                        }

                    } else {
                        let alertView = UIAlertController(title: "Login Problem", message: "Connection failed" as String, preferredStyle:.Alert)
                        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                        alertView.addAction(okAction)
                        self.presentViewController(alertView, animated: true, completion: nil)
                    }
                } else {
                    let alertView = UIAlertController(title: "Login Problem", message: "Connection error." as String, preferredStyle:.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                    alertView.addAction(okAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                }
            } catch {
                let alertView = UIAlertController(title: "Login Problem", message: "Server error." as String, preferredStyle:.Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alertView.addAction(okAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
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
