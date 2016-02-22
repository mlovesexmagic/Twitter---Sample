//
//  TweetTableViewCell.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/8/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var tweetDescription: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var replyButton: UIImageView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var llikeImageView: UIImageView!
    @IBOutlet weak var retwetImageView: UIImageView!
    
    
    
//    var tweet: Tweet! {
//        didSet {
//             timeLabel.text = calculateTimeStamp(tweet.createdAt!.timeIntervalSinceNow)
//        }
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileView.layer.cornerRadius = 5
        profileView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    

}
