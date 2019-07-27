//
//  MasterViewModel.swift
//  NYTimes
//
//  Created by Radha Krishna on 27/07/19.
//  Copyright © 2019 Radha Krishna. All rights reserved.
//

import UIKit

class MasterViewModel: NSObject {
    var delegate:articleUpdateDelegate?
    
    var dataArray = [[String:AnyObject]]() {
        didSet {
            delegate?.getArticleData(data: dataArray)
        }
    }
    
    override init() {
        super.init()
        
        let urlString = "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=kV9WzlQR0ZAIiTOSZyGbGwI4H6bEqTiQ"
        let service:APIManager = APIManager()
        service.serveiceHandler(url: urlString) { [weak self](data) in
            do
            {
                let  jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                if let jsondata = jsonData["results"] as? [[String:AnyObject]] {
                    self?.dataArray = jsondata
                } else {
                    print("Articles: Error while getting data")
                }
            }
            catch {
                print("invalidResponse")
            }
        }
    }

}
