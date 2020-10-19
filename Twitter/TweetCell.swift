//
//  TweetCell.swift
//  Twitter
//
//  Created by Jennifer Lopez on 10/10/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    var favorited : Bool = false
    var tweetID : Int = -1
    var retweeted : Bool = false
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tweet: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBAction func favTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.likeTweet(tweetID: tweetID, success: {
                self.setFav(true)
            }, failure: { (err) in
                print ("Unable to like tweet")
            })
        }
        else {
            TwitterAPICaller.client?.unlikeTweet(tweetID: tweetID, success: {
                self.setFav(false)
            }, failure: { (err) in
                print ("Unable to dislike")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweet(true)
        }, failure: { (err) in
            print ("Unable to retweet")
        })
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setFav (_ isFavorited: Bool) {
        favorited = isFavorited
        if (favorited) {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        else {
              likeButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
    }
    
    func setRetweet (_ isRetweeted: Bool) {
        retweeted = isRetweeted
        if (retweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            retweetButton.isEnabled = true
        }
    }
}
