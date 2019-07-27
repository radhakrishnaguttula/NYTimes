//
//  MasterTableViewCell.swift
//  NYTimes
//
//  Created by Radha Krishna on 27/07/19.
//  Copyright © 2019 Radha Krishna. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {

    @IBOutlet weak var desclabel: UILabel!
    @IBOutlet weak var authlabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var calendarImage: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.arrowImage.image = self.arrowImage.image!.withRenderingMode(.alwaysTemplate)
        self.arrowImage.tintColor = UIColor.darkGray
        self.calendarImage.image = self.calendarImage.image!.withRenderingMode(.alwaysTemplate)
        self.calendarImage.tintColor = UIColor.gray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    
}
