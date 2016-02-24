//
//  TweetTableViewCell.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/8/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import SwiftMoment

protocol TweetTableViewCellDelegate {
//    func userDidReplyToTweet(tweet: Tweet)
//    func userDidFavoriteTweet(tweet: Tweet)
//    func userDidRetweetTweet(tweet: Tweet)
//    func userDidTapImageProfile(sender: UITapGestureRecognizer, user: User)
}

class TweetTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var tweetDescription: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var llikeImageView: UIImageView!
    @IBOutlet weak var retwetImageView: UIImageView!
   // @IBOutlet weak var ImageToProfileButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var mediaView: UIImageView!
    
    
    var profileImageTapRecognizer: UITapGestureRecognizer?
    
    var tweetCell: Tweet? {
        didSet {
            profileView.setImageWithURL(NSURL(string: tweetCell!.user!.profileViewUrl!)!)
            userName.text = tweetCell!.user!.name!
            userHandle.text = ("@\(tweetCell!.user!.handle!)")
            tweetDescription.text = tweetCell!.text!
            retweetCount.text = "\(tweetCell!.retweetCount as Int)"
            likeCount.text = "\(tweetCell!.favCount as Int)"
            timeLabel.text = timeSpan(tweetCell!.createdAt!)

            //images post
            mediaView.image = nil
            if let mediaFile = (tweetCell!.mediaURL) {
                mediaView.setImageWithURL(mediaFile)
                mediaView.sizeToFit()
                mediaView.layer.cornerRadius = 4
                mediaView.clipsToBounds = true
            }
            self.layoutIfNeeded()
        }
    }
    
    var delegate: TweetTableViewCell?

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
    
    //convert time method
    func timeSpan(createdAt: NSDate?) -> String {
        let durationAgo = (moment() - moment(createdAt!))
        if durationAgo.hours >= 24 {
            return "\(Int(durationAgo.days))d"
        } else if durationAgo.minutes >= 60 {
            return "\(Int(durationAgo.hours))h"
        } else if durationAgo.seconds >= 60 {
            return "\(Int(durationAgo.minutes))m"
        } else {
            return "1m"
        }
    }
    
//
//    func heartAnimation() {
//        let ImageName = "heart-"
//        var imagesNames = [ "\(ImageName)1","\(ImageName)2","\(ImageName)3","\(ImageName)4","\(ImageName)5","\(ImageName)6","\(ImageName)7","\(ImageName)8","\(ImageName)9","\(ImageName)10"]
//        var images = [UIImage]()
//        
//        for i in 0..<imagesNames.count{
//            images.append(UIImage(named: imagesNames[i])!)
//        }
//        imageView!.animationImages = images
//        imageView!.startAnimating()
//    }

}
