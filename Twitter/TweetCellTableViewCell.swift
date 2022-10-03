//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Eakjot Hundal on 9/26/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited:Bool = false
    var retweeted:Bool = false
    var tweetID:Int = -1
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if (tobeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID) {
                self.setFavorite(true)
            } failure: { Error in
                print("Favorite did not succed: \(Error)")
            }

        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { Error in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
        
    }
    
    @IBAction func retweet(_ sender: Any) {
        
        let tobeRetweet = !retweeted
        if (tobeRetweet) {
            TwitterAPICaller.client?.retweetTweet(tweetID: tweetID, success: {
                self.setRetweeted(true)
            }, failure: { Error in
                print("Error in retweeting: \(Error)")
            })
            
        } else {
            TwitterAPICaller.client?.unretweetTweet(tweetID: tweetID, success: {
                self.setRetweeted(false)
            }, failure: { Error in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        retweeted = isRetweeted
        if (retweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
