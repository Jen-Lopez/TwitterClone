//
//  TweetVC.swift
//  Twitter
//
//  Created by Jennifer Lopez on 10/18/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetVC: UIViewController {
    @IBOutlet weak var tweetContent: UITextView!
    
    @IBAction func cancelTweet(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createTweet(_ sender: Any) {
        if (!tweetContent.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweet: tweetContent.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (err) in
                print ("Error posting tweet \(err)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetContent.becomeFirstResponder()

    }

}
