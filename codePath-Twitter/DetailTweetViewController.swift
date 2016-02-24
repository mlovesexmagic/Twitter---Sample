//
//  DetailTweetViewController.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/15/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import SwiftMoment

class DetailTweetViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailHandleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!       //retweet count
    @IBOutlet weak var favLabel: UILabel!           //favorite count
    @IBOutlet weak var likesText: UILabel!          //like text for display only, do not edit
    @IBOutlet weak var retweetText: UILabel!        //retweet text for display only
//    @IBOutlet weak var retweetButton: UIButton!
//    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    //@IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var profilebButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
   // @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var moreImage: UIImageView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var tweetTitle: UILabel!
    @IBOutlet weak var birdLogo: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    
    //@IBOutlet weak var mediaView: UIImageView!
    var replyTo: String?
    var replyID: Int?
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var tweetar: Tweet!
    var timeSpanText: String?
    var liked: Bool = false
    var retweeted: Bool = false
    private var detailTweets =  [Tweet]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerDesign()
        showProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProfile(){
        nameLabel.text = tweetar!.user!.name!
        detailHandleLabel.text = ("@\(tweetar!.user!.handle!)")
        detailTweetLabel.text = tweetar!.text!
        detailImageView.setImageWithURL(NSURL(string: tweetar!.user!.profileViewUrl!)!)
        //timeLabel.text = timeSpanText  //displays timeSpan
        let tweetDate = parseTwitterDate("\(tweetar!.createdAt!)")
        timeLabel.text = tweetDate
        //print("this is the date \(tweetDate)")
        favCheck()
        retweetCheck()
        
        replyID = tweetar!.id!
        //print("is issssss\(replyID)")
        replyTo = detailHandleLabel.text
        userDefaults.setValue(replyID, forKey: "detailReplyTo_ID")
        userDefaults.setValue(replyTo, forKey: "detailReplyTo_Handle")
    }
    
    func bannerDesign() {
        //customizeNavBar()
        self.navigationController?.navigationBarHidden = true
        
        moreImage.image = moreImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        moreImage.tintColor = UIColor(red: (85/255.0), green: (172/255.0), blue: (238/255.0), alpha: 1.0)
        
        searchImage.image = searchImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        searchImage.tintColor = UIColor(red: (85/255.0), green: (172/255.0), blue: (238/255.0), alpha: 1.0)
        
        backImage.image = backImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        backImage.tintColor = UIColor(red: (85/255.0), green: (172/255.0), blue: (238/255.0), alpha: 1.0)
        
        birdLogo.image = birdLogo.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        birdLogo.tintColor = UIColor(red: (85/255.0), green: (172/255.0), blue: (238/255.0), alpha: 1.0)
        
        tweetTitle.textColor = UIColor(red: (85/255.0), green: (172/255.0), blue: (238/255.0), alpha: 1.0)
    }
    
    
   //Shows the date in proper formate
    func parseTwitterDate(twitterDate:String)->String?{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"

        let indate = formatter.dateFromString(tweetar!.createdAtString!)
        let outputFormatter = NSDateFormatter()
        outputFormatter.dateFormat = "h:mm a · dd MMM yy"
        var outputDate:String?
        if let d = indate {
            outputDate = outputFormatter.stringFromDate(d)
        }
        return outputDate;
    }

    @IBAction func onBackButtonClicked(segue: UIStoryboardSegue) {
//        print("Back button clicked")
//        let storyboard = UIStoryboard(name: "Timeline", bundle: nil)
//        let ntabController = storyboard.instantiateInitialViewController() as! UITabBarController
//        self.presentViewController(ntabController, animated: true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    //Action to like/unlike animation
    @IBAction func onLikeClicked(sender: AnyObject) {
        if liked == false {
            TwitterClient.sharedInstance.favoriteWithCompletion(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.liked = true
                print("You liked: \(self.tweetar!.user!.name!)'s post")
                self.tweetar.favCount += 1
                
                var likeCountNum = self.tweetar!.favCount
                if likeCountNum > 1000 {
                    likeCountNum = likeCountNum / 1000
                }
                
                self.favLabel.text = "\(likeCountNum)"
                self.likeImageView.image = UIImage(named: "like-clicked")

                self.favCheck()
            }
        }else{
            TwitterClient.sharedInstance.unfavoriteWithCompletion(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.liked = false
                print("You unliked: \(self.tweetar!.user!.name!)'s post")
                self.tweetar!.favCount -= 1
                self.favLabel.text = "\(self.tweetar!.favCount)"
                self.likeImageView.image = UIImage(named: "like")

                self.favCheck()
            }
        }
    }
    
    
    //Action to retweet/unretweet animation
    @IBAction func onRetweetClicked(sender: AnyObject) {
        if retweeted == false {
            TwitterClient.sharedInstance.retweetWithCompletion(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.retweeted = true
                print("You retweeted: \(self.tweetar!.user!.name!)'s post")
                //self.tweetar.retweetCount += 1
                
                //trying to reduce the count size once goes over 1000
                let tweetCountNum = Int (self.tweetar.retweetCount += 1)
                print("num is \(tweetCountNum)")
                if tweetCountNum >= 1000 {
                    print("num2 is \(tweetCountNum)")

                    let finaTweetCountNum = tweetCountNum / 1000
                    print("num3 is \(finaTweetCountNum)k")

                    self.retweetLabel.text = "\(finaTweetCountNum)k)"

                }
                else {
                   // self.retweetLabel.text = "\(tweetCountNum)"
                }
                self.retweetImageView.image = UIImage(named: "retweet-clicked")
                self.retweetCheck()
            }
        }else{
            TwitterClient.sharedInstance.unRetweetWithCompletion(["id": tweetar!.id!]) { (tweet, error) -> () in
                self.retweeted = false
                print("You unretweeted: \(self.tweetar!.user!.name!)'s post")
                self.tweetar!.retweetCount -= 1
                self.retweetLabel.text = "\(self.tweetar!.retweetCount)"
                self.retweetImageView.image = UIImage(named: "retweet")
                self.retweetCheck()
            }
        }
    }

    func favCheck(){
        //display text only when likes, else hides
        let favCounts = tweetar!.favCount as Int
        if favCounts == 0 {
            likesText.text = ""
            favLabel.text = ""
        } else {
            favLabel.text = "\(tweetar!.favCount as Int)"
            likesText.text = "LIKES"
        }
    }
    
    
    func retweetCheck(){
        //display text only when likes, else hides
        let retweetCounts = tweetar!.retweetCount as Int
        if retweetCounts == 0 {
            retweetText.text = ""
            retweetLabel.text = ""
        } else {
            retweetLabel.text = "\(tweetar!.retweetCount as Int)"
            retweetText.text = "RETWEETS"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "detailToProfile") {
            print("Profile clicked")
            let profileViewController: ProfileViewController  = segue.destinationViewController as! ProfileViewController
            profileViewController.tweetsProfile = tweetar
        }
    }
    
    
  
    
    //Method to switch screen to "ComposeViewController"
    func segueToComposer(replyTo: String!){
        
        let storyboard = UIStoryboard(name: "TweetScreen", bundle: nil)
        let vController = storyboard.instantiateViewControllerWithIdentifier("ComposeViewController") as UIViewController
        self.presentViewController(vController, animated: true, completion: nil)
    }
    
    @IBAction func onReplyClicked(sender: AnyObject) {
        segueToComposer(nil)
    }
    
    func customizeNavBar() {
        //self.navigationItem.title = "Details"
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Tweet", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
//        let backButton = UIBarButtonItem(title: "< Tweet", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
//        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 20)!], forState: UIControlState.Normal)
//        navigationItem.backBarButtonItem = backButton

    }
    
    override func viewDidDisappear(animated: Bool) {
       // self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
       // self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

}

//
//extension DetailTweetViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell") as! TweetTableViewCell
//        cell.tweetCell = detailTweets[indexPath.row]
//        //cell.delegate = self
//        cell.selectionStyle = UITableViewCellSelectionStyle.None
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return detailTweets.count
//    }
//}
