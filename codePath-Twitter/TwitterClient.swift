//
//  TwitterClient.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/7/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


let twitterConsumerKey = "BGxDuKpBdiLNDCw83POa7CScY";
let twitterConsumerSecret = "r5r4N4y13dKz8x8Kv2yMpQpB727Kc1w7ePN4UX35D1s4M74mh5";
let twitterBaseURL = NSURL(string: "https://api.twitter.com");

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(
                baseURL: twitterBaseURL,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret
            );
        }
        
        return Static.instance;
    }
    
}