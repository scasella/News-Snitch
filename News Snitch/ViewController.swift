//
//  ViewController.swift
//  News Snitch
//
//  Created by Stephen Casella on 12/27/15.
//  Copyright © 2015 Stephen Casella. All rights reserved.
//

import UIKit
var linkArray = [String]()
var titleArray = [String]()
var providerArray = [String]()
var teaserArray = [String]()

var linkObj = 0

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var picker: UIPickerView?
    @IBOutlet var teaserLabel: UILabel?
    @IBOutlet var goButton: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadHeadlines(newsDict["Trending"]!)
        picker?.showsSelectionIndicator = false
        goButton!.layer.cornerRadius = 12.0
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func morePressed() {
     linkObj = teaserArray.indexOf(teaserLabel!.text!)!
        performSegueWithIdentifier("toSummaryView", sender: self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titleArray.count
    }
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleArray[row]
    }
    
    
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(100.0)
    }
    
    
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 312
    }
    
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        teaserLabel!.text = teaserArray[row]
        teaserLabel!.alpha = 0.0
        UIView.animateWithDuration(0.65, delay: 0.0, options: [.CurveEaseOut], animations: {
        self.teaserLabel!.alpha = 0.75

        }, completion: nil)
    
    }
    
    
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.numberOfLines = 3
        pickerLabel.textColor = UIColor.blackColor()
        pickerLabel.font = UIFont.systemFontOfSize(21)
        pickerLabel.textAlignment = NSTextAlignment.Center
        pickerLabel.text = titleArray[row]
        return pickerLabel
    }
    
    
    
    func downloadHeadlines(url: String) {
        let request = NSURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error.debugDescription)
            } else {
                do { let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary
                    
                    if let items = dict!["results"] as? NSArray {
                        
                        for item in items {
                            
                            let title = item["title"]
                            
                            linkArray.append(title! as! String)
                            
                            let titleName = item["title/_text"]
                            
                            titleArray.append(titleName! as! String)
                            
                            let provider = item["provider"]
                            
                            providerArray.append(provider! as! String)
                            
                            let teaser = item["teaser"]
                            
                            teaserArray.append(teaser! as! String)
                            
                        }
                        
                        dispatch_sync(dispatch_get_main_queue()){
                            
                            self.picker?.reloadAllComponents()
                            self.teaserLabel!.text = teaserArray[0]
                            
                        }
                        
                        // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                        
                        //  })
                    }
                    
                    
                } catch {
                    
                }
                // self.downloadData()
            }
        }
        
        task.resume()

    }

}

