//
//  BSServiceManger.swift
//  SampleListTask
//
//  Created by Narendra Biswa on 02/04/20.
//  Copyright © 2020 Narendra Biswa. All rights reserved.
//


    

    import Foundation
    import CoreData

    //public typealias SuccessCallback = (NSDictionary, NSError?) ->Void
    public typealias SuccessCallback = (_ json: [AnyHashable: Any]?) -> Void
    public typealias SuccessCallbackWithObjects = (_ objects: [Any]?) -> Void
    public typealias ErrorCallback = (_ error: Error?) -> Void
    public typealias ProgressBlock = (_ progress: Float) -> Void
    public typealias DataSuccessCallback = (_ json: Data) -> Void

    class ServiceManger :NSObject
    {
        static let sharedInstance :
            ServiceManger = {
            let instance = ServiceManger()
            return instance
        }()
        
        override init() {
            super.init()
        }
        
        func requestWithParameters(paramaters params: Any, andMethod path: String, onSuccess: @escaping SuccessCallback, onError: @escaping ErrorCallback) {
        
        
            guard let url = URL(string: path) else {return}
                
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

    



