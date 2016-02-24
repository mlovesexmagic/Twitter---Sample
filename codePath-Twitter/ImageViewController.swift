//
//  ImageViewController.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/21/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var backImagge: UIImageView!
    @IBOutlet weak var birdImage: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    
    var imageTweet: Tweet!
    let userDefaults = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageURL = userDefaults.URLForKey("mediaURL_String")
        imageView.setImageWithURL(imageURL!)
        
        backImagge.image = backImagge.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        birdImage.image = birdImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        replyImage.image = replyImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        retweetImage.image = retweetImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        likeImage.image = likeImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        
        backImagge.tintColor = UIColor.whiteColor()
        birdImage.tintColor = UIColor.whiteColor()
        replyImage.tintColor = UIColor.whiteColor()
        retweetImage.tintColor = UIColor.whiteColor()
        likeImage.tintColor = UIColor.whiteColor()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButtonClicked(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Timeline", bundle: nil)
        let navController = storyboard.instantiateInitialViewController() as! UINavigationController
        self.presentViewController(navController, animated: true, completion: nil)
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
