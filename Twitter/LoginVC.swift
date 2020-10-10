//  LoginVC.swift
//  Twitter
//  Created by Jennifer Lopez on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.bool(forKey: "isLoggedIn")) {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }

    @IBAction func onLogin(_ sender: Any) {
        let tweetURL = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: tweetURL, success: {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }, failure: { (err) in
            print("Could not log in")
        })
    }
    
}
