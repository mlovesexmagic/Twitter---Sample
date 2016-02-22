//
//  DetailTweetViewController.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/15/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailHandleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var likesText: UILabel!
    @IBOutlet weak var retweetText: UILabel!
    
    var tweetar: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = tweetar!.user!.name!
        detailHandleLabel.text = ("@\(tweetar!.user!.handle!)")
        detailTweetLabel.text = tweetar!.text!
        detailImageView.setImageWithURL(NSURL(string: tweetar!.user!.profileViewUrl!)!)

        
        //display retweet when retweeted
        let retweetCounts = tweetar.retweetCount as! Int
        if retweetCounts > 0  {
            retweetLabel.text = "\(tweetar.retweetCount as! Int)"
            retweetText.text = "RETWEETS"
        }
        
        //display text only when likes
        let favCounts = tweetar!.favCount as! Int
        if favCounts > 0 {
            favLabel.text = "\(tweetar!.favCount as! Int)"
            likesText.text = "LIKES"
        }
    
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
