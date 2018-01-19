//
//  UpComingVisitCell.swift
//  TestProject
//
//  Created by Raameshchandra on 1/18/18.
//  Copyright © 2018 Patel, Sanjay. All rights reserved.
//

import UIKit

class UpComingVisitCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var providerImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var specalityLabel: UILabel!
    @IBOutlet weak var providerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        providerImage.layer.cornerRadius = providerImage.frame.size.width/2
        providerImage.layer.borderWidth = 1.0
        providerImage.clipsToBounds = true

        cellView.layer.borderColor = UIColor.lightGray.cgColor
        cellView.layer.borderWidth = 1
        cellView.layer.cornerRadius = 5
        cellView.layer.shadowOffset = CGSize(width: -1, height: 1)
        cellView.layer.shadowRadius = 1
        cellView.layer.shadowOpacity = 0.5
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
