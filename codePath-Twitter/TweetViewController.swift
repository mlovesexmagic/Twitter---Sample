//
//  TweetViewController.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/8/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//


//************************************ Warning ********************

//****************** Command F search " TO DO " for unfinished work




import UIKit
import SwiftMoment



class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var tweetsMain =  [Tweet]()
    var tweets: [Tweet]?
    var tweetsBackup: Tweet?
    var refreshControl: UIRefreshControl!
    
    //testing
//    var bgView: UIView!
//    var animated: Bool = true
//    var imageNow: UIImageView?

    var liked: Bool = false
    var retweeted: Bool = false
    
    //userDefaults
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        setupInfiniteScrollView()
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.estimatedRowHeight = 120
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.reloadData()
        }
        tableView.reloadData()
}
    
  
    //************************************************************************************************//
    //********************************* Helpful Actions **********************************************//
    //************************************************************************************************//
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
        print("User logged out!")
    }
    
    //Action to retweet/unretweet animation
    @IBAction func onRetweetButtonClicked(sender: UIButton) {
        let subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetTableViewCell
        
        if retweeted == false {
            TwitterClient.sharedInstance.retweetWithCompletion(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
                cell.retwetImageView.image = UIImage(named: "retweet-clicked")
                self.retweeted = true
                print("You retweeted \(self.tweets![indexPath.row].user!.name!)'s post")
                self.tweets![indexPath.row].retweetCount += 1
                cell.retweetCount.text = "\(self.tweets![indexPath.row].retweetCount)"
//                    let indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
//                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            }
        }else{
            TwitterClient.sharedInstance.unfavoriteWithCompletion(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
        
                cell.retwetImageView.image = UIImage(named: "retweet")
                self.retweeted = false
                print("You retweeted \(self.tweets![indexPath.row].user!.name!)'s post")
                self.tweets![indexPath.row].retweetCount -= 1
                cell.retweetCount.text = "\(self.tweets![indexPath.row].retweetCount)"
            }
        }
    }

    
    //Action to like/unlike animation
    @IBAction func onLikeButtonClicked(sender: UIButton) {
        let subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetTableViewCell
        
        if liked == false {
            TwitterClient.sharedInstance.favoriteWithCompletion(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
                
                
                //heart animation when fav clicked
                let ImageName = "heart-"
                var imagesNames = [ "\(ImageName)1","\(ImageName)2","\(ImageName)3","\(ImageName)4","\(ImageName)5","\(ImageName)6","\(ImageName)7","\(ImageName)8","\(ImageName)9","\(ImageName)10"]
                var images = [UIImage]()
                
                for i in 0..<imagesNames.count{
                    images.append(UIImage(named: imagesNames[i])!)
                    cell.llikeImageView.animationImages = images
                }
                
                cell.llikeImageView.animationDuration = 1
                cell.llikeImageView.animationRepeatCount = 1
                cell.llikeImageView.image = UIImage(named: "like-clicked")
                cell.llikeImageView.startAnimating()
    
                self.liked = true
                print("You liked \(self.tweets![indexPath.row].user!.name!)'s post")
                self.tweets![indexPath.row].favCount += 1
                cell.likeCount.text = "\(self.tweets![indexPath.row].favCount)"
          }
       }else{
            
            TwitterClient.sharedInstance.unfavoriteWithCompletion(["id": tweets![indexPath.row].id!]) { (tweet, error) -> () in
                cell.llikeImageView.image = UIImage(named: "like")
                self.liked = false
    
                print("You unliked \(self.tweets![indexPath.row].user!.name!)'s post")
                self.tweets![indexPath.row].favCount -= 1
                cell.likeCount.text = "\(self.tweets![indexPath.row].favCount)"
            }
        }
    }
    
    //Action of button from top right screen to Compose a tweet
    @IBAction func composeTweet(sender: AnyObject) {
        segueToComposer(nil)
    }

    //Action of reply button within the tweet cell to Compose a reply tweet
    @IBAction func onReplyClicked(sender: AnyObject) {
        segueToComposer(nil)
    }
    
    //tapping on tweet's media image will segue to ImageViewController
    @IBAction func onTapMedia(sender: AnyObject) {
        
//        //*** TO DO *** full screen image
//        let subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
//        let indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
//        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetTableViewCell
//        
//        let mediaFile = userDefaults.URLForKey("mediaURL_String")
//
//        cell.imageView!.setImageWithURL(mediaFile!)
//        cell.imageView!.frame = self.view.frame
//        cell.imageView!.backgroundColor = .blackColor()
//        cell.imageView!.contentMode = .ScaleAspectFit
//        cell.imageView!.userInteractionEnabled = true
//        cell.imageView!.multipleTouchEnabled = true
//        self.view.addSubview(cell.imageView!)
//        let tap = UITapGestureRecognizer(target: self, action: "dismissFullscreenImage:")
//        cell.imageView!.addGestureRecognizer(tap)
//        tableView.reloadData()
 
    }
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    

    
    //************************************************************************************************//
    //*********************************  Helpful Methods  ********************************************//
    //************************************************************************************************//
    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion:  { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweetIndexPath = tweets![indexPath.row]

        cell.profileView.setImageWithURL(NSURL(string: tweetIndexPath.user!.profileViewUrl!)!)
        cell.userName.text = tweetIndexPath.user!.name!
        cell.userHandle.text = ("@\(tweetIndexPath.user!.handle!)")
        cell.tweetDescription.text = tweetIndexPath.text!
        cell.retweetCount.text = "\(tweetIndexPath.retweetCount as Int)"
        cell.likeCount.text = "\(tweetIndexPath.favCount as Int)"
        cell.timeLabel.text = timeSpan(tweetIndexPath.createdAt!)
        
        cell.mediaView.image = nil

        userDefaults.setInteger(tweets![indexPath.row].id!, forKey: "replyTo_ID")
        //userDefaults.setValue(tweets![indexPath.row].user?.handle!, forKey: "replyTo_handle")
        userDefaults.setValue(("@\(tweetIndexPath.user!.handle!)"), forKey: "replyTo_handle")
        
        
        if let mediaFile = (tweetIndexPath.mediaURL) {
            cell.mediaView.setImageWithURL(mediaFile)
            userDefaults.setURL(mediaFile, forKey: "mediaURL_String")
            cell.mediaView.sizeToFit()
            cell.mediaView.layer.cornerRadius = 4
            cell.mediaView.clipsToBounds = true
        }
        return cell
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
    
    //Method to switch screen to "ComposeViewController"
    func segueToComposer(replyTo: String!){
        let storyboard = UIStoryboard(name: "TweetScreen", bundle: nil)
        let vController = storyboard.instantiateViewControllerWithIdentifier("ComposeViewController") as UIViewController
        self.presentViewController(vController, animated: true, completion: nil)
    }
    
    //********* Segue *******
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //pass data to "DetailsViewController"
       if (segue.identifier == "cellToDetails") {
            cellData(sender)
            let detailTweetViewController = segue.destinationViewController as! DetailTweetViewController
            detailTweetViewController.tweetar = tweetsBackup
        }
    }
    
    func cellData(sender: AnyObject?) {
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let tweetss = tweets![indexPath!.row]
        tweetsBackup = tweetss
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //****** Infinite Scroll ******// issue, contents repeating
    var isMoreDataLoading = false
    var loadingMoreView: InfiniteScroll?
    let twitterApiParams = [ "since_id": 20, "count": 20 ]
    
    var loadMoreOffset = 20
    
    //infinite scroll
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if !isMoreDataLoading {
            //calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            //when the user has scrolled past the threshold, start requesting
            if scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging {
                isMoreDataLoading = true
                
                let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScroll.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                //load more data
                loadMoreData()
            }
        }
    }
    
    func loadMoreData() {
        
        //call Twitter API to load the next set of data
        let twitterApiParams = [ "since_id": self.loadMoreOffset, "count": 20 ]
        TwitterClient.sharedInstance.homeTimelineWithParams(twitterApiParams) { tweets, error in
            
            if error != nil {
                self.delay(2.0, closure: {
                    self.loadingMoreView?.stopAnimating()
                })
            } else {
                self.delay(0.5, closure: { Void in
                    self.loadMoreOffset += 20
                    self.tweets?.appendContentsOf(tweets!)
                    self.tableView.reloadData()
                    self.loadingMoreView?.stopAnimating()
                    self.isMoreDataLoading = false
                })
            }
        }
    }
    
    func setupInfiniteScrollView() {
        let frame = CGRectMake(0, tableView.contentSize.height,
            tableView.bounds.size.width,
            InfiniteScroll.defaultHeight
        )
        loadingMoreView = InfiniteScroll(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview( loadingMoreView! )
        var insets = tableView.contentInset
        insets.bottom += InfiniteScroll.defaultHeight
        tableView.contentInset = insets
    }
    
    func delay(delay: Double, closure: () -> () ) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure
        )
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
   
}

//extension TweetViewController: TweetTableViewCellDelegate {
//    func userReplyToTweet(tweet: Tweet) {
//        tweetsBackup = tweet
//    }
//}

