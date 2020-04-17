//
//  ViewModel.swift
//  SampleListTask
//
//  Created by Narendra Biswa on 17/04/20.
//  Copyright © 2020 Narendra Biswa. All rights reserved.
//

import Foundation
import UIKit


struct ViewModel  {
   
    var viewcontroller : ViewController?
  
    func serviceCalling()
    {
        
        ServiceManger.sharedInstance.requestWithParameters(paramaters: "", andMethod: Constants.Base.BASE_URL, onSuccess: {(_ json: Any) -> Void in
            
            self.viewcontroller?.refreshControl.endRefreshing()
            
            let folderdict : NSDictionary = json as! [String:Any] as NSDictionary
            self.viewcontroller?.title = folderdict["title"] as? String
            self.viewcontroller?.getStoresArray = folderdict["rows"] as! [AnyObject];
            self.viewcontroller?.tableView.reloadData()
            
        },
                                                             
                                                             onError: {(_ error: Error?) -> Void in
                                                                self.viewcontroller?.refreshControl.endRefreshing()
                                                                
                                                                print("Failed to login:\(error?.localizedDescription ?? "")")
        })
    }
   
    
}
