//
//  ViewController.swift
//  Calorie Counter
//
//  Created by Wasim Ahmad on 6/14/17.
//  Copyright © 2017 Wasim Ahmad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnwalk: UIButton!
    @IBOutlet weak var btnrun: UIButton!
    
    @IBOutlet weak var lbldisplay: UILabel!
    @IBOutlet weak var txtdistance: UITextField!
    @IBOutlet weak var txttime: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calcRunning(_ sender: UIButton) {
        let d:Double? = Double(txtdistance.text!)
        let t:Double? = Double(txttime.text!)
        let runFactor = 2.8
        
        let calc = d! * t! * runFactor
        lbldisplay.text = ( "\(calc)cal")
    }

    @IBAction func calcWalking(_ sender: UIButton) {
    
        let d:Double? = Double(txtdistance.text!)
        let t:Double? = Double(txttime.text!)
        let walkFactor = 1.3
        
        let calcwalk = d! * t! * walkFactor
        lbldisplay.text = ( "\(calcwalk)cal")
    }
}

