//
//  SummaryViewController.swift
//  News Snitch
//
//  Created by Stephen Casella on 12/27/15.
//  Copyright © 2015 Stephen Casella. All rights reserved.
//

import UIKit

var linkURL = ""

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryField: UITextView!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    @IBOutlet weak var blurView: UIView!
    
    @IBAction func linkPressed() {
      UIApplication.sharedApplication().openURL(NSURL(string: linkURL)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.layer.cornerRadius = 16.0
        blurView.clipsToBounds = true 
        downloadData(linkObj, titleLabel: titleLabel!, summaryField: summaryField!, loadingView: loadingView!)
    }
    
    
}
