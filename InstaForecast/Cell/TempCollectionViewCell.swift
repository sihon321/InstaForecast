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
      tempLabel.text = String(describing: info.main?.temp ?? 273 - 273)
      humidityLabel.text = String(describing: info.main?.humidity ?? 0) + "%"
      windLabel.text = String(describing: info.wind?.speed ?? 0) + " m/s"
    }
    
    static func cellSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 30.0, height: 135)
    }
}
