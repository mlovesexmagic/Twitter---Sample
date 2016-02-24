//
//  LogInViewController.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/17/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    
    var tweets: [Tweet]?
    
    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                //self.performSegueWithIdentifier("loginSegue", sender: self)
                let storyboard = UIStoryboard(name: "Timeline", bundle: nil)
                let ntabController = storyboard.instantiateInitialViewController() as! UITabBarController
                self.presentViewController(ntabController, animated: true, completion: nil)
            } else {
            }
        }    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImage.image = logoImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        logoImage.tintColor = UIColor(red: (85/255.0), green: (172/255.0), blue: (238/255.0), alpha: 1.0)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
