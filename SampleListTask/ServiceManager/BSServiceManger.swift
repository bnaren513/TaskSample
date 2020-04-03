//
//  BSServiceManger.swift
//  SampleListTask
//
//  Created by Narendra Biswa on 02/04/20.
//  Copyright © 2020 Narendra Biswa. All rights reserved.
//


    //
    //  BSServiceManager.swift
    //  Sendsafe
    //
    //  Created by Pradeep Sharma on 24/04/18.
    //  Copyright © 2018 Pradeep Sharma. All rights reserved.
    //

    import Foundation
    import CoreData

    //public typealias SuccessCallback = (NSDictionary, NSError?) ->Void
    public typealias SuccessCallback = (_ json: [AnyHashable: Any]?) -> Void
    public typealias SuccessCallbackWithObjects = (_ objects: [Any]?) -> Void
    public typealias ErrorCallback = (_ error: Error?) -> Void
    public typealias ProgressBlock = (_ progress: Float) -> Void
    public typealias DataSuccessCallback = (_ json: Data) -> Void

    class BSServiceManger :NSObject
    {
        static let sharedInstance : BSServiceManger = {
            let instance = BSServiceManger()
            return instance
        }()
        
        override init() {
            super.init()
        }
        
        func requestWithParameters(paramaters params: Any, andMethod path: String?, onSuccess: @escaping SuccessCallback, onError: @escaping ErrorCallback) {
         //UserDefaults.standard.set(userTokenId, forKey: "userTokenId")
            
//          var url : String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts"
//             //var urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
//              var searchURL : NSURL = NSURL(string: url as String)!
//              print(searchURL)
             // let url1 = URL(string: url)
        
       
           // let serviceurl = URL(string: Constants.Base.BASE_URL)
//            var request : URLRequest = URLRequest(url: searchURL as URL)
//            request.httpMethod = "GET"
//
//
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         //   _ = (params as AnyObject).description
          //
           // let newparams : Dictionary<String, Any> = params as! Dictionary
           // newparams["domain"] = String(Constants.Base.DOMAIN)
            
           // let jsonData: Data? = try? JSONSerialization.data(withJSONObject: newparams, options: .prettyPrinted)
//            var jsonString: String? = nil
//            if let aData = jsonData
//            {
//                jsonString = String(data: aData, encoding: .utf8)
//            }
//            print("\(jsonString ?? "")")
//            let postData: Data? = jsonString?.data(using: .utf8, allowLossyConversion: true)
//            request.httpBody = postData
//            let dataTask = URLSession.shared.dataTask(with: request) {
//                data,response,error in
//                print("anything")
//                do {
//                    if let data = data,
//                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
//
//                        print(jsonResult)
//                                    //Use GCD to invoke the completion handler on the main thread
//                        DispatchQueue.main.async() {
//                            onSuccess(jsonResult as? [AnyHashable : Any])
//                        }
//                    }
//                }
//                catch let error as NSError
//                {
//
//                    print(error.localizedDescription)
//                    print(error.code)
//                    onError(error.localizedDescription as? Error)
//                }
//            }
//            dataTask.resume()
//        }
           
//            var request = URLRequest(url: searchURL as URL)
//             //request.httpMethod = "GET"
//             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            // let jsonEncoder = JSONEncoder()
//             //let httpBody = try? jsonEncoder.encode(uploadingDictionary)
//             //request.httpBody = httpBody
//
//             URLSession.shared.dataTask(with: request) { (recData, response, error) in
//
//                 if let data = recData {
//                     do{
//                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:AnyObject]]
//                         print("JSON IS ",json)
//                     }catch {
//                         print("failed ",error.localizedDescription)
//                     }
//                 }
//             }.resume()
       
           // var request = URLRequest(url: searchURL as URL)
//        request.httpMethod = "GET"
//      //  request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
//       // request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            print(response!)
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//                print(json)
//            } catch {
//                print("error")
//            }
//        })
//
//        task.resume()
//
//
//        }
//
        
       let urlStr = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
                guard let url = URL(string: urlStr) else {return}
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let dataTask = URLSession.shared.dataTask(with: url){ (data, response, error) in
                    // print(data)
                    //  print(error)
                    //   print(response)
                    if let errorNew = error{
                        print(errorNew)
                        print(errorNew.localizedDescription)
                       
                                                                    
                        onError(errorNew.localizedDescription as? Error)
                    }else{
                        guard let dataObj = data else{return}
                        do {
                            
                            let str = String(data: dataObj, encoding: .ascii)
                            guard let finalData = str?.data(using: .utf8) else {return}
                            if let jsonObj = try JSONSerialization.jsonObject(with: finalData, options: .allowFragments) as? [AnyHashable : Any]{
                                print(jsonObj)
                                 DispatchQueue.main.async() {
                                                            onSuccess(jsonObj as? [AnyHashable : Any])
                                                        }
                            }
                        }catch{

                                                print(error.localizedDescription)
                                               
                                                onError(error.localizedDescription as? Error)
                        }
                    }
                }
                  dataTask.resume()
            }
}

    



