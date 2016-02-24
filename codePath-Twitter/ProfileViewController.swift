
//
//  ProfileViewController.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/17/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var birdImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLable: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var moreImage: UIImageView!

    var tweetsProfile: Tweet!  //data passed from DetailsViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = true
        
        backImageView.image = backImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        birdImageView.image = birdImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        searchImage.image = searchImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        moreImage.image = moreImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        backImageView.tintColor = UIColor.whiteColor()
        birdImageView.tintColor = UIColor.whiteColor()
        searchImage.tintColor = UIColor.whiteColor()
        moreImage.tintColor = UIColor.whiteColor()
        getProfile()
        
    }

    func getProfile() {
        TwitterClient.sharedInstance.getProfileBanner(["id": tweetsProfile!.id!]) { (tweet, error) -> () in
            
            self.bannerImageView.setImageWithURL(NSURL(string: self.tweetsProfile!.user!.profileBannerURL!)!)
            self.profileImage.setImageWithURL(NSURL(string: self.tweetsProfile!.user!.profileViewUrl!)!)
            self.nameLabel.text = self.tweetsProfile!.user!.name!
            self.handleLable.text = self.tweetsProfile!.user!.handle!
            self.taglineLabel.text = self.tweetsProfile!.user!.tagline!
            self.locationLabel.text = self.tweetsProfile!.user!.location!
            self.followerCount.text = "\(self.tweetsProfile!.user!.follower!)"
            self.followingCount.text = "\(self.tweetsProfile!.user!.following!)"

            //print("********* web is \(self.tweetsProfile!.user!.weblink)")
            if let websiteLink = (self.tweetsProfile!.user!.weblink) {
               
                //*******************************************
                //******* To Do use the weblink for webview
                //******************************************
                self.websiteLabel.text = "\(websiteLink)"
                
                print("website  is not nil then \(websiteLink)")
            }
        }
    }
    
    @IBAction func backProfileBtn(segue: UIStoryboardSegue) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    override func viewWillAppear(animated: Bool) {
       // self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
