//
//  ComposeViewController..swift
//  SocialApp
//
//  Created by Студент on 22/02/2017.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit
import Accounts
import Social

class ComposeViewController_: UIViewController, UITextViewDelegate {
    
    var selectedAccount : ACAccount!
    
    @IBOutlet weak var tweetContent: UITextView!
    
    @IBOutlet weak var postButton: UIButton!
    
    @IBOutlet weak var postActivity: UIActivityIndicatorView!
    
    @IBAction func dismissView(_ sender: UIButton) {
        
    }
    
    
    @IBAction func postToTwitter(_ sender: UIButton) {
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
