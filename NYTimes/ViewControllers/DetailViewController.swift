//
//  DetailViewController.swift
//  NYTimes
//
//  Created by Radha Krishna on 27/07/19.
//  Copyright © 2019 Radha Krishna. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mainCaption: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var subCaption: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descView: UITextView!
    
    
    var articleData = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setupUI() {
        if let description = articleData["title"] {
            mainCaption.text = description as? String
        }
        if let author = articleData["byline"] {
            authorLabel.text = author as? String
        }
        
        if let date = articleData["published_date"] {
            dateLabel.text = date as? String
        }
        
        if let abstract = articleData["abstract"] {
            descView.text = abstract as? String
        }
        
        
        if let imageData = articleData["media"] as? [[String:Any]] {
            if let caption = imageData.first!["caption"] as? String {
                subCaption.text = caption
            }
            let imagesArray = imageData.first!["media-metadata"] as? [[String: AnyObject]]
            let thumbImageData = imagesArray?[2]
            let thumbImage = thumbImageData?["url"] as? String
            
            DispatchQueue.global(qos: .default).async(execute:{ ()->Void in
                do
                {
                    let data = try Data.init(contentsOf: URL(string: thumbImage!)!)
                    DispatchQueue.main.async(execute:{ () -> Void in
                        self.mainImage.image = UIImage(data: data)
                        self.view.layoutSubviews()
                        self.subCaption.frame.size = CGSize(width: self.mainImage.frame.size.width, height: self.subCaption.frame.size.height)
                    })
                }
                catch{
                    print("Error in reading Data")
                }
            })
        }
    }


}
