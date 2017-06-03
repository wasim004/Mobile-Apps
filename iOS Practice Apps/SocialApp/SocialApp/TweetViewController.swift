//
//  TweetViewController.swift
//  SocialApp
//
//  Created by Студент on 22/02/2017.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet weak var tweetAuthorAvatar: UIImageView!
    
    @IBOutlet weak var tweetAuthorName: UILabel!
    
    @IBOutlet weak var tweetText: UITextView!
    
    @IBAction func dismissView(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    var selectedTweet : NSDictionary?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let userData = selectedTweet?.object(forKey: "user") as! NSDictionary
        tweetText.text? = selectedTweet?.object(forKey: "text") as! String
        tweetAuthorName.text? = userData.object(forKey: "name") as! String
        let imageURLString = userData.object(forKey: "profile_image_url_https") as! String
        let imageURL = URL(string: imageURLString)
        if
            let imageData = NSData(contentsOf: imageURL!) {
            DispatchQueue.main.async {
                self.tweetAuthorAvatar.image = UIImage(data: imageData as Data)
            } }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
