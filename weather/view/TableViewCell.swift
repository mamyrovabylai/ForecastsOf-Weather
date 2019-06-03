//
//  TableViewCell.swift
//  weather
//
//  Created by Абылайхан on 06.11.17.
//  Copyright © 2017 Абылайхан. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tempImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var highestTempLabel: UILabel!
    @IBOutlet weak var lowestTempLabel: UILabel!
    
    func updateUI(weatherModel: weatherModel){
        dayLabel.text = weatherModel.day
        descriptionLabel.text = weatherModel.description
        highestTempLabel.text = weatherModel.max
        lowestTempLabel.text = weatherModel.min
        tempImage.image = UIImage(named: weatherModel.description)
    }
    
    
    
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
