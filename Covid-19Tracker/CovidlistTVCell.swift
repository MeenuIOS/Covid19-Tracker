//
//  CovidlistTVCell.swift
//  Covid-19Tracker
//
//  Created by Sarath Sasi on 08/04/20.
//  Copyright © 2020 XCoders. All rights reserved.
//

import UIKit

class CovidlistTVCell: UITableViewCell {

    @IBOutlet weak var casesLabel: UILabel!
    @IBOutlet weak var recoverdLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var country: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
