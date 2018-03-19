//
//  TempCollectionViewCell.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 18..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import UIKit

class TempCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ info: List) {
        tempLabel.text = String(describing: (info.listMain?.temp)! - 273)
        humidityLabel.text = String(describing: (info.listMain?.humidity)!) + "%"
        windLabel.text = String(describing: (info.listWind?.speed)!) + " m/s"
    }
    
    static func cellSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 135)
    }
}
