//
//  APIManager.swift
//  NYTimes
//
//  Created by Radha Krishna on 27/07/19.
//  Copyright © 2019 Radha Krishna. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    func serveiceHandler(url:String,completionHandler:@escaping (_ data:Data) ->Void) {
        
        LoaderController.sharedInstance.showLoader()
        
        let memoryCapacity = 10 * 1024 * 1024; // 10 MB
        let diskCapacity = 10 * 1024 * 1024; // 10 MB
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "shared_cache")
        
        
        // custom configuration
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        configuration.urlCache = cache
        
        
        let session:URLSession = URLSession.init(configuration: configuration)
        
        let myurl:URL = URL(string: url)!
        
        let task:URLSessionDataTask? = session.dataTask(with: myurl, completionHandler:{ (_ data:Data?,_ response:URLResponse?,_ error:Error?) ->Void in
            
            if error != nil{
                print(error!)
            }
            else
            {
                let httpresponse = response as? HTTPURLResponse
                let httpcode = httpresponse?.statusCode
                if httpcode != 200
                {
                    print("Http Status code:\(String(describing: httpcode))")
                }
                
                OperationQueue.main.addOperation( {()->Void in
                    completionHandler(data!)
                    LoaderController.sharedInstance.removeLoader()
                    
                })
            }
        })
        task?.resume()
    }
}
