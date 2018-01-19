//
//  PastVistCell.swift
//  TestProject
//
//  Created by Raameshchandra on 1/18/18.
//  Copyright © 2018 Patel, Sanjay. All rights reserved.
//

import UIKit

class PastVistCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var providerImageView: UIImageView!
    @IBOutlet weak var specalityLabel: UILabel!
    @IBOutlet weak var providerNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        providerImageView.layer.cornerRadius = providerImageView.frame.size.width/2
        providerImageView.layer.borderWidth = 1.0
        providerImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
