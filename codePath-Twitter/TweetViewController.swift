//
//  TweetViewController.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/8/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import SwiftMoment

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?
    var liked: Bool = false
    var retweeted: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //display "Tweet" instead of "back"  
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Tweet", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

        
        tableView.dataSource = self
        tableView.delegate = self
        
        //set tableviewcell row height
        tableView.estimatedRowHeight = 120
        
        //tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
        
    }
    
    func testTweets() {
        let tweet = tweets![0]
        print(tweet.user!.name)

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        
        cell.profileView.setImageWithURL(NSURL(string: tweets![indexPath.row].user!.profileViewUrl!)!)
        cell.userName.text = tweets![indexPath.row].user!.name!
        cell.userHandle.text = ("@\(tweets![indexPath.row].user!.handle!)")
        cell.tweetDescription.text = tweets![indexPath.row].text!
        cell.retweetCount.text = "\(tweets![indexPath.row].retweetCount as! Int)"
        cell.likeCount.text = "\(tweets![indexPath.row].favCount as! Int)"           
        cell.timeLabel.text = timeSpan(tweets![indexPath.row].createdAt!)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let detailTweetViewController = segue.destinationViewController as! DetailTweetViewController
        let tweetss = tweets![indexPath!.row]
        detailTweetViewController.tweetar = tweetss
        
    }
    
    @IBAction func onRetweetButtonClicked(sender: UIButton) {
        let subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetTableViewCell
        
        if retweeted == false {
            TwitterClient.sharedInstance.retweetWithCompletion(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
                
                cell.retwetImageView.image = UIImage(named: "retweet-clicked")
                self.retweeted = true
                
                
                    print("You retweeted: \(self.tweets![indexPath.row].user!.name!)'s post")
                    self.tweets![indexPath.row].retweetCount += 1
                cell.retweetCount.text = "\(self.tweets![indexPath.row].retweetCount)"

//                    let indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
//                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
                
                
            }
        }else{
            
            TwitterClient.sharedInstance.unfavoriteWithCompletion(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
               
                cell.retwetImageView.image = UIImage(named: "retweet")
                self.retweeted = false
                
                print("You retweeted: \(self.tweets![indexPath.row].user!.name!)'s post")
                self.tweets![indexPath.row].retweetCount -= 1
                cell.retweetCount.text = "\(self.tweets![indexPath.row].retweetCount)"
//                let indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
//                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
                
                
            }
        }

    }

    
    //takes care of the like/unlike animation
    @IBAction func onLikeButtonClicked(sender: UIButton) {

        let subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetTableViewCell
        
        if liked == false {
            TwitterClient.sharedInstance.favoriteWithCompletion(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
                
                cell.llikeImageView.image = UIImage(named: "like-clicked")
                self.liked = true
                
                print("You liked: \(self.tweets![indexPath.row].user!.name!)'s post")
                self.tweets![indexPath.row].favCount += 1
                cell.likeCount.text = "\(self.tweets![indexPath.row].favCount)"
                
//                    let indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
//                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            }
       }else{
            
            TwitterClient.sharedInstance.unfavoriteWithCompletion(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
                
                cell.llikeImageView.image = UIImage(named: "like")
                self.liked = false
                
                //if (tweet != nil) {
                print("You unliked: \(self.tweets![indexPath.row].user!.name!)'s post")
                self.tweets![indexPath.row].favCount -= 1
                cell.likeCount.text = "\(self.tweets![indexPath.row].favCount)"
//                    let indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
//                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
                
                //}
            }
        }
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
    
    

    
}

