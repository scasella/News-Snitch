//
//  Models.swift
//  News Snitch
//
//  Created by Stephen Casella on 12/27/15.
//  Copyright © 2015 Stephen Casella. All rights reserved.
//

import UIKit

let newsDict = ["Trending": "https://api.import.io/store/data/a7ad8327-390c-4de5-947e-d1e17809186f/_query?input/webpage/url=http%3A%2F%2Fnews.google.com%2F%3Fsdm%3DTEXT%26authuser%3D0&_user=269d78c6-495d-43df-899d-47320fc07fe4&_apikey=269d78c6495d43df899d47320fc07fe4886fa6efe4d7561df8557e1696cb76a1fef8f22d1807eda04e3cf5335799c8a1920d4d62f0801e9f5ecdb4b5901f7f4f5fa653f59f1b71fe22582aea9acc9f69", "U.S.": "https://api.import.io/store/data/a8dc3aad-1453-4875-9662-6fd97a420a0d/_query?input/webpage/url=https%3A%2F%2Fnews.google.com%2Fnews%2Fsection%3Fpz%3D1%26topic%3Dn%26sdm%3DTEXT%26authuser%3D0&_user=269d78c6-495d-43df-899d-47320fc07fe4&_apikey=269d78c6495d43df899d47320fc07fe4886fa6efe4d7561df8557e1696cb76a1fef8f22d1807eda04e3cf5335799c8a1920d4d62f0801e9f5ecdb4b5901f7f4f5fa653f59f1b71fe22582aea9acc9f69", "Business": "https://api.import.io/store/data/6eb3c0eb-35f6-4517-a679-b7159b72d954/_query?input/webpage/url=https%3A%2F%2Fnews.google.com%2Fnews%2Fsection%3Fpz%3D1%26topic%3Db%26sdm%3DTEXT%26authuser%3D0&_user=269d78c6-495d-43df-899d-47320fc07fe4&_apikey=269d78c6495d43df899d47320fc07fe4886fa6efe4d7561df8557e1696cb76a1fef8f22d1807eda04e3cf5335799c8a1920d4d62f0801e9f5ecdb4b5901f7f4f5fa653f59f1b71fe22582aea9acc9f69", "Tech": "https://api.import.io/store/data/c6f47ce2-0a6e-4027-bd9d-1746512c40c4/_query?input/webpage/url=https%3A%2F%2Fnews.google.com%2Fnews%2Fsection%3Fpz%3D1%26topic%3Dtc%26sdm%3DTEXT%26authuser%3D0&_user=269d78c6-495d-43df-899d-47320fc07fe4&_apikey=269d78c6495d43df899d47320fc07fe4886fa6efe4d7561df8557e1696cb76a1fef8f22d1807eda04e3cf5335799c8a1920d4d62f0801e9f5ecdb4b5901f7f4f5fa653f59f1b71fe22582aea9acc9f69", "Media":"https://api.import.io/store/data/3e3c1783-2f7f-49ac-9f87-696e6e760603/_query?input/webpage/url=https%3A%2F%2Fnews.google.com%2Fnews%2Fsection%3Fpz%3D1%26topic%3De%26sdm%3DTEXT%26authuser%3D0&_user=269d78c6-495d-43df-899d-47320fc07fe4&_apikey=269d78c6495d43df899d47320fc07fe4886fa6efe4d7561df8557e1696cb76a1fef8f22d1807eda04e3cf5335799c8a1920d4d62f0801e9f5ecdb4b5901f7f4f5fa653f59f1b71fe22582aea9acc9f69","Health":"https://api.import.io/store/data/9123d445-0b1a-4732-a80b-e79e6525b073/_query?input/webpage/url=https%3A%2F%2Fnews.google.com%2Fnews%2Fsection%3Fpz%3D1%26topic%3Dm%26sdm%3DTEXT%26authuser%3D0&_user=269d78c6-495d-43df-899d-47320fc07fe4&_apikey=269d78c6495d43df899d47320fc07fe4886fa6efe4d7561df8557e1696cb76a1fef8f22d1807eda04e3cf5335799c8a1920d4d62f0801e9f5ecdb4b5901f7f4f5fa653f59f1b71fe22582aea9acc9f69","Sports":"https://api.import.io/store/data/cf0d5716-cf73-4e8b-8bfa-48e4ca11e3a1/_query?input/webpage/url=https%3A%2F%2Fnews.google.com%2Fnews%2Fsection%3Fpz%3D1%26topic%3Ds%26sdm%3DTEXT%26authuser%3D0&_user=269d78c6-495d-43df-899d-47320fc07fe4&_apikey=269d78c6495d43df899d47320fc07fe4886fa6efe4d7561df8557e1696cb76a1fef8f22d1807eda04e3cf5335799c8a1920d4d62f0801e9f5ecdb4b5901f7f4f5fa653f59f1b71fe22582aea9acc9f69","Science":"https://api.import.io/store/data/6f9a719e-ba33-466b-87ac-caaa624a325d/_query?input/webpage/url=https%3A%2F%2Fnews.google.com%2Fnews%2Fsection%3Fpz%3D1%26topic%3Dsnc%26sdm%3DTEXT%26authuser%3D0&_user=269d78c6-495d-43df-899d-47320fc07fe4&_apikey=269d78c6495d43df899d47320fc07fe4886fa6efe4d7561df8557e1696cb76a1fef8f22d1807eda04e3cf5335799c8a1920d4d62f0801e9f5ecdb4b5901f7f4f5fa653f59f1b71fe22582aea9acc9f69"]

func downloadData(linkObj: Int, titleLabel: UILabel, summaryField: UITextView, loadingView: UIActivityIndicatorView) {
  
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {

        let mappedURLString = "https://api.import.io/store/data/13523395-b0a2-4791-92e1-0c609717b53a/_query?input/url=" + linkArray[linkObj] + "&_user=269d78c6-495d-43df-899d-47320fc07fe4&_apikey=269d78c6495d43df899d47320fc07fe4886fa6efe4d7561df8557e1696cb76a1fef8f22d1807eda04e3cf5335799c8a1920d4d62f0801e9f5ecdb4b5901f7f4f5fa653f59f1b71fe22582aea9acc9f69"
        
        let mappedURL = NSURL(string: mappedURLString)
        
        let data = NSData(contentsOfURL: mappedURL!)
        
        if data != nil {
            
            do { let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                if let items = jsonData["results"] as? NSArray {
                    
                    for item in items {
                        
                        let summary = item["summarytext"]!
                        
                        dispatch_sync(dispatch_get_main_queue()){
                            titleLabel.text = titleArray[linkObj]
                            summaryField.text = "\(summary!)"
                            summaryField.textColor = UIColor.blackColor()
                            summaryField.textAlignment = .Justified
                            
                            linkURL = linkArray[linkObj]
                          
                            loadingView.hidden = true
                            loadingView.stopAnimating()
                            summaryField.hidden = false
                            titleLabel.hidden = false
                            
                            summaryField.font = UIFont.systemFontOfSize(16.0)
                        }
                    }}
                
            } catch {
                print("not a dictionary")
                
            } }
    })
    
}
