//
//  ViewController.swift
//  SampleListTask
//
//  Created by Narendra Biswa on 02/04/20.
//  Copyright © 2020 Narendra Biswa. All rights reserved.
//

import UIKit
import Nuke


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var getStoresArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        // Refreshconrol
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
          tableView.addSubview(refreshControl)
        
        // Service implementation
        serviceCalling();
    }
    @objc func refresh(sender:AnyObject) {
                       // Code to refresh table view
        serviceCalling()
        
                       }
   func serviceCalling()
   {

    BSServiceManger.sharedInstance.requestWithParameters(paramaters: "", andMethod: Constants.Base.BASE_URL, onSuccess: {(_ json: Any) -> Void in

        self.refreshControl.endRefreshing()
        
        let folderdict : NSDictionary = json as! [String:Any] as NSDictionary
        self.title = folderdict["title"] as? String
        self.getStoresArray = folderdict["rows"] as! [AnyObject];
        self.tableView.reloadData()
       
    },
       
    onError: {(_ error: Error?) -> Void in
        self.refreshControl.endRefreshing()

        print("Failed to login:\(error?.localizedDescription ?? "")")
    })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getStoresArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomtableviewCell", for: indexPath) as! CustomTableViewCell
    let dict: NSDictionary = getStoresArray[indexPath.row] as! NSDictionary
        
        cell.rowTitleLabel.text = (dict["title"] ?? "") as? String
        cell.rowDescriptionLabel.text = (dict["description"] ?? "") as? String
        if let string = (dict["imageHref"]  as? String)
        {
            let url:URL = URL.init(string:string)!
            print("url = \(url)");
           
               //  cell.rowImageView.loadImageWithUrl(url)
            Nuke.loadImage(
                with: url,
                               options: ImageLoadingOptions(
                                   placeholder: UIImage.init(named: "placeHolder_icon"),
                                   transition: .fadeIn(duration: 0.33)
                               ),
                               into: cell.rowImageView
                           )
        
        }
        else
        {
                       cell.rowImageView.image =   UIImage.init(named: "placeHolder_icon")
        }
        return cell;
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               
           return UITableView.automaticDimension
       }
       
       func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           
           return UITableView.automaticDimension
       }





}
