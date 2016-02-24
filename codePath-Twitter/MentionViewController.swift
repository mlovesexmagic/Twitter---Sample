//
//  MentionViewController.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/23/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

class MentionViewController: UIViewController {

    @IBOutlet weak var mentionsTableView: UITableView!
    
    private var tweetsMention = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mentionsTableView.delegate = self
        mentionsTableView.dataSource = self

        TwitterClient.sharedInstance.mentionsTimeline(nil) { (tweet, error) -> () in
            
        if error == nil {
            self.tweetsMention = tweet!
            self.mentionsTableView.estimatedRowHeight = 120
            //self.mentionsTableView.rowHeight = UITableViewAutomaticDimension
            self.mentionsTableView.reloadData()
            }
        }
        mentionsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}



extension MentionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.mentionsTableView.dequeueReusableCellWithIdentifier("TweetTableViewCell") as! TweetTableViewCell
        cell.tweetCell = tweetsMention[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsMention.count
    }
}
