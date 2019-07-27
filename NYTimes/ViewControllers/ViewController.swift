//
//  ViewController.swift
//  NYTimes
//
//  Created by Radha Krishna on 27/07/19.
//  Copyright © 2019 Radha Krishna. All rights reserved.
//

import UIKit

protocol articleUpdateDelegate {
    func getArticleData(data:[[String:AnyObject]])
}


class ViewController: UIViewController ,articleUpdateDelegate {
    
    @IBOutlet weak var popArticleList: UITableView!
    fileprivate var viewModel:MasterViewModel?
    
    
    private var articlesArray = [[String:AnyObject]]() {
        didSet {
            self.popArticleList.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.configureTableView()
        
    }
    
    func configureTableView() {
        
        popArticleList?.estimatedRowHeight = 120
        popArticleList?.rowHeight = 130
        popArticleList?.separatorStyle = .none
        popArticleList?.register(MasterTableViewCell.nib, forCellReuseIdentifier: MasterTableViewCell.identifier)
        viewModel = MasterViewModel.init()
        viewModel?.delegate = self
        popArticleList?.dataSource = self
        popArticleList.delegate = self
    }
    
    
    func getArticleData(data: [[String:AnyObject]]) {
        self.articlesArray = data
    }
    
}


extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(articlesArray.count)
        return articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MasterTableViewCell.identifier, for: indexPath) as? MasterTableViewCell
        let articleData = self.articlesArray[indexPath.row]
        
        if let description = articleData["title"] {
            cell?.desclabel.text = description as? String
        }
        if let author = articleData["byline"] {
            cell?.authlabel.text = author as? String
        }
        
        if let date = articleData["published_date"] {
            cell?.datelabel.text = date as? String
        }
        
        if let imageData = articleData["media"] as? [[String:Any]] {
            let imagesArray = imageData.first!["media-metadata"] as? [[String: AnyObject]]
            let thumbImageData = imagesArray?.first
            let thumbImage = thumbImageData?["url"] as? String
            
            DispatchQueue.global(qos: .default).async(execute:{ ()->Void in
                do
                {
                    let data = try Data.init(contentsOf: URL(string: thumbImage!)!)
                    DispatchQueue.main.async(execute:{ () -> Void in
                        cell?.thumbImage.image = UIImage(data: data)
                        cell?.thumbImage.drawBorder(color: .gray, width: 2, radius: (cell?.thumbImage.bounds.width)! / 2, mask: true)
                    })
                }
                catch{
                    print("Error in reading Data")
                }
            })
        }
        
        return cell!
    }
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let Controller = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        Controller?.articleData = self.articlesArray[indexPath.row]
        self.navigationController?.pushViewController(Controller!, animated: true)
    }
}



extension UIView {
    func dropShadow(color: UIColor, opacity: Float, offSet: CGSize, radius: CGFloat, scale: Bool) {
        layer.masksToBounds = false
        self.clipsToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
    
    func drawBorder(color: UIColor, width: CGFloat, radius: CGFloat, mask: Bool) {
        layer.masksToBounds = true
        layer.borderWidth = width
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
    }
    
}
