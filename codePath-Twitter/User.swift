//
//  User.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/8/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import Foundation

var _currentUser: User?
let currentUserKey = "thisCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var handle: String?
    var profileViewUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    var statusPostCount: Int?
    var followerCount: Int?
    var friendCount: Int?
    var profileBannerURL: String?
    var location: String?
    var follower: Int?
    var following: Int?
    
    
    var weblink: NSURL?
    //var entities: NSDictionary?
//    var url: NSDictionary?
//    var urls: NSDictionary?

    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        //***** Obtaining the user's website address in profileView
        //print("step one")
        if let entities = (dictionary["entities"] as? NSDictionary) {
           // print("step two")
            if let url = (entities["url"] as? NSDictionary) {
               // print("step there")
                if let urls = (url["urls"] as? [NSDictionary]) {
                   // print("step four")
                    if urls.count > 0 {
                        for key in urls{
                            let IGotTheLinkYeahhhhomfggg = (key["display_url"] as? String)!
                            weblink = NSURL(string: IGotTheLinkYeahhhhomfggg)
                            //print("website \(weblink)")
                        }
                    }
                }
            }
        }

        
       
        name = dictionary["name"] as? String
        handle = dictionary["screen_name"] as? String
        profileViewUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        profileBannerURL = dictionary["profile_banner_url"] as? String
        location = dictionary["location"] as? String
        follower = dictionary["followers_count"] as? Int
        following = dictionary["friends_count"] as? Int
        //let websitepath = dictionary.valueForKeyPath("url") as? String
       // print("******web is \(websitepath)")
        //entites = dictionary["entities"] as? NSDictionary
        //website = dictionary.valueForKeyPath("url.urls.display_url") as? String
        //print("website \(website)")
        //print("banner url \(profileBannerURL) ")
    }
    
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
                    } catch _ {
                }
            }
        }
            return _currentUser
    }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions())
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch _ {
                    
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
   
}
