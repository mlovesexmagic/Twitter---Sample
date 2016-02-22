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
    
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        id = dictionary["id"] as? Int
 
        createdAtString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)

        
        favCount = dictionary["favorite_count"] as! Int
        retweetCount = dictionary["retweet_count"] as! Int

    }
    
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    

    
    
    
    
//    //convinience method that takes array of dictionaries and returns array of tweets
//    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
//
//        var tweets = [Tweet]()
//
//        for dictionary in array {
//            tweets.append(Tweet(dictionary: dictionary))
//        }
//        return tweets
//    }
    
    
    
    //convinience method that takes array of dictionaries and returns array of tweets
    class func tweetAsDictionary(dict: NSDictionary) -> Tweet {
        
        let tweet = Tweet(dictionary: dict)
        return tweet
    }
}
