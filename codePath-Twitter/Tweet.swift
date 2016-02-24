//
//  Tweet.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/8/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var id: Int?
    var favCount: Int
    var retweetCount: Int
    
    var mediaURL: NSURL?
    var replyUserStatusID: String?

    
    
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        text = dictionary["text"] as? String
        id = dictionary["id"] as? Int
        replyUserStatusID = dictionary["id_str"] as? String

        //shows time ago created the post
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAtString = dictionary["created_at"] as? String
        createdAt = formatter.dateFromString(createdAtString!)
        //print("createdAt \(createdAt)")
        
        favCount = dictionary["favorite_count"] as! Int
        retweetCount = dictionary["retweet_count"] as! Int
        
        //extended_entities > [media] > video_info > [variants] > content_type = "video/mp4" > url
        //***** Obtaining the tweet's media file in timeline
        //print("step one")  //making sure it's not nil
        if let entities = (dictionary["extended_entities"] as? NSDictionary) {
           // print("step two")
            if let media = (entities["media"] as? [NSDictionary]) {
             //    print("step there")
                if media.count > 0 {
                    for key in media{
                        let IGotTheLinkYeahhhhomfggg = (key["media_url"] as? String)!
                        let mediaFileSize = "\(IGotTheLinkYeahhhhomfggg):small"
                        mediaURL = NSURL(string: mediaFileSize)
                        //print("website \(mediaURL)")
                    }
                }
            }
        }
    }
    
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
            //***************
            //print("tweets: \(dictionary)")

        }
        
        return tweets
    }
    
    //convinience method that takes array of dictionaries and returns array of tweets
    class func tweetAsDictionary(dict: NSDictionary) -> Tweet {
        
        let tweet = Tweet(dictionary: dict)
        return tweet
    }
    
    
}
