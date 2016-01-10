//
//  ViewController.swift
//  News Snitch
//
//  Created by Stephen Casella on 12/27/15.
//  Copyright © 2015 Stephen Casella. All rights reserved.
//

import UIKit
import iAd

var linkArray = [String]()
var titleArray = [String]()
var providerArray = [String]()
var teaserArray = [String]()

var linkObj = 0

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ADBannerViewDelegate, AKPickerViewDataSource, AKPickerViewDelegate, UIGestureRecognizerDelegate {
    
    let titles = ["Trending", "U.S.", "Business", "Tech", "Media", "Health", "Sports", "Science"]

    @IBOutlet weak var hPickerView: AKPickerView?
    @IBOutlet weak var picker: UIPickerView?
    @IBOutlet weak var teaserLabel: UILabel?
    @IBOutlet weak var goButton: UIButton?
    @IBOutlet weak var bannerAd: ADBannerView!
    @IBOutlet weak var helperLabel: UILabel?

    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.bannerAd.alpha = 1
        }
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.bannerAd.alpha = 0
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "morePressed")
        self.picker!.addGestureRecognizer(tap)
        tap.delegate = self
    
        bannerAd.delegate = self
        bannerAd.alpha = 0
        self.canDisplayBannerAds = true
        
        downloadHeadlines(newsDict["Trending"]!)
        picker?.showsSelectionIndicator = false
        goButton!.layer.cornerRadius = 12.0
        
        hPickerView!.delegate = self
        hPickerView!.dataSource = self
        
        hPickerView!.font = UIFont.systemFontOfSize(16.0)
        hPickerView!.highlightedFont = UIFont.systemFontOfSize(16.0)
        hPickerView!.pickerViewStyle = .Flat
        hPickerView!.maskDisabled = false
        hPickerView!.reloadData()
    }
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
    @IBAction func morePressed() {
     linkObj = teaserArray.indexOf(teaserLabel!.text!)!
        performSegueWithIdentifier("toSummaryView", sender: self)
    }
    
    
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return self.titles.count
    }
    
    
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        return self.titles[item]
    }
    
    
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        helperLabel!.alpha = 0.0
        /*hPickerView!.alpha = 0.9
        UIView.animateWithDuration(5.0) { () -> Void in
            self.hPickerView!.alpha = 0.4
        }*/
          downloadHeadlines(newsDict["\(titles[item])"]!)
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
        helperLabel!.alpha = 0.0
        teaserLabel!.text = teaserArray[row]
        teaserLabel!.alpha = 0.0
        UIView.animateWithDuration(0.65, delay: 0.0, options: [.CurveEaseOut], animations: {
        self.teaserLabel!.alpha = 0.75

        }, completion: nil)
        UIView.animateWithDuration(15.0) { () -> Void in
            self.helperLabel!.alpha = 0.5
        }
    
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
        
        picker!.userInteractionEnabled = false
        
        linkArray.removeAll()
        titleArray.removeAll()
        providerArray.removeAll()
        teaserArray.removeAll()
        
        //picker!.reloadAllComponents()
        teaserLabel!.alpha = 0.3
        teaserLabel!.text = "Gathering headlines..."
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
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
                            
                            self.picker!.userInteractionEnabled = true
                            self.picker!.multipleTouchEnabled = true 
                            self.picker!.reloadAllComponents()
                            self.teaserLabel!.text = teaserArray[0]
                            self.teaserLabel!.alpha = 0.9
                            self.helperLabel!.alpha = 0.0
                            UIView.animateWithDuration(15.0, animations: { () -> Void in
                                self.helperLabel!.alpha = 0.5
                            })
                            self.picker!.selectRow(0, inComponent: 0, animated: true)
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
        })
    }
    
}

