//
//  ComposeViewController.swift
//  codePath-Twitter
//
//  Created by Zhipeng Mei on 2/17/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate, TweetCellDelegate {

    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var replyTo: String?
    //private var placeHolderText = "What's fappening?"
    var placeholderLabel : UILabel!

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var wordCount: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tweetSendButton: UIButton!
    
    var tweetCompose: Tweet?
    private var tweetCom = [Tweet]()

    
    var replyId: Int?
    var replyHandle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        
        textView.delegate = self //Without setting the delegate you won't be able to track UITextView events
        userProfile.setImageWithURL(NSURL(string: User.currentUser!.profileViewUrl!)!)
        //userProfile.layer.cornerRadius = 5
        tweetSendButton.layer.cornerRadius = 4
        
        // my own name/handle
//        userName.text = User.currentUser?.name
//        userHandle.text = User.currentUser?.handle
        
        //userHandle.text = ("@\(tweetCompose!.user!.handle!)")
        replyHandle = userDefaults.stringForKey("detailReplyTo_Handle")
        
        
        if replyHandle != nil {
            textView!.text = replyHandle
        }
        else {
            // placeholder
            placeholderLabel = UILabel()
            placeholderLabel.text = "What's fappening?"
            placeholderLabel.font = UIFont.italicSystemFontOfSize(textView.font!.pointSize)
            placeholderLabel.sizeToFit()
            textView.addSubview(placeholderLabel)
            placeholderLabel.frame.origin = CGPointMake(5, textView.font!.pointSize / 2)
            placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
            placeholderLabel.hidden = !textView.text.isEmpty
        }

      
    }
    
    // protocol call
    func userReplyToTweet(reply_screenNameYOOO: String) {

    }
    
    // keyboard show/hide determins the "tweet" button's position
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.bottomView.frame.origin.y -= keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.bottomView.frame.origin.y += keyboardSize.height
        }
    }
    

    //counting down on characters
    func textViewDidChange(textView: UITextView) {
        
        //placeholderLabel.hidden = !textView.text.isEmpty
        
        //print(textView.text)
        if  0 < (141 - textView.text!.characters.count) {
            tweetSendButton.enabled = true
            wordCount.text = "\(140 - textView.text!.characters.count)"
        }
        else{
            wordCount.text = "\(140 - textView.text!.characters.count)"
            tweetSendButton.enabled = false
        }
    }
    
    
    @IBAction func sendTweet(sender: AnyObject) {
        if textView.text!.isEmpty {
            let alertController = UIAlertController(title: "Tweet Body Pissing", message: "You can't send an empty Bannanana!", preferredStyle: .Alert)
            let acceptAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(acceptAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            TwitterClient.sharedInstance.postTweet(textView.text!, replyId: replyId, completion: {(success, error) -> () in
                if success != nil {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        }
    }
    

    
    func insertTwitterHandle(handle: String) {
        textView.text = handle
        textView.delegate?.textViewDidChange!(textView)
    }
    
    //Dismiss ComposeView when clicked on stop
    @IBAction func cancelTweet(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

