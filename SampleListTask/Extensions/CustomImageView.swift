//
//  CustomImageView.swift
//  SampleFlickerImages
//
//  Created by Narendra Biswa on 03/04/20.
//  Copyright © 2020 Narendra Biswa. All rights reserved.
//

import UIKit
 let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
        var imageURL: URL?
        
       // let activityIndicator = UIActivityIndicatorView()
        
        func loadImageWithUrl(_ url: URL) {
            
            // setup activityIndicator...
//            activityIndicator.color = .orange
//
//            addSubview(activityIndicator)
//            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
            imageURL = url
             
            image = nil
           // activityIndicator.startAnimating()
            
            // retrieves image if already available in cache
            if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
                
                self.image = imageFromCache
               // activityIndicator.stopAnimating()
                return
            }
            
            // image does not available in cache.. so retrieving it from url...
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error as Any)
                  //  self.activityIndicator.stopAnimating()
                    self.image =   UIImage.init(named: "placeHolder_icon")
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    
                    if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                        
                        if self.imageURL == url {
                            self.image = imageToCache
                        }
                        else
                        {
                            self.image = UIImage.init(named: "placeHolder_icon")
                        }
                        
                        imageCache.setObject(imageToCache, forKey: url as AnyObject)
                    }
                   // self.activityIndicator.stopAnimating()
                })
            }).resume()
        }
    


}
