//
//  FavoritesCell.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/21/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {

    lazy var favoritesCityImage: UIImageView = {
           let iv = UIImageView()
           iv.clipsToBounds = true
           iv.contentMode = .scaleAspectFill
           iv.layer.borderWidth = 4
           iv.layer.borderColor = UIColor.blue.cgColor
           return iv
         }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
