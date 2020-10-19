//
//  HomeTV.swift
//  Twitter
//
//  Created by Jennifer Lopez on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTV: UITableViewController {
    
    var tweets = [NSDictionary]()
    var numOfTweets : Int!
    
    func loadTweets(){
        let reqURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let param = ["count": 10]
        TwitterAPICaller.client?.getDictionariesRequest(url: reqURL, parameters: param, success: { (tweets : [NSDictionary]) in
            self.tweets.removeAll()
            for tw in tweets {
                self.tweets.append(tw)
            }
            self.tableView.reloadData()
            
        }, failure: { (err) in
            print ("Unable to load tweets")
        })
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweet", for: indexPath) as! TweetCell
        let userDict = tweets[indexPath.row]["user"] as! NSDictionary
        cell.name.text = userDict["name"] as! String
        cell.tweet.text = tweets[indexPath.row]["text"] as! String

        let imageURL = URL(string: (userDict["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            cell.photo.image = UIImage(data: imageData)
        }
        
        cell.setFav(tweets[indexPath.row]["favorited"] as! Bool)
        cell.tweetID = tweets[indexPath.row]["id"] as! Int
        cell.setRetweet(tweets[indexPath.row]["retweeted"] as! Bool)
//        cell.retweeted = tweets[indexPath.row]["retweeted"] as! Bool
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweets()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
}
