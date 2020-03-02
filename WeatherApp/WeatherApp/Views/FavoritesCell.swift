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
        iv.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return iv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        contentView.addSubview(favoritesCityImage)
        favoritesCityImage.translatesAutoresizingMaskIntoConstraints = false
        
        favoritesCityImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        favoritesCityImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  10).isActive = true
        favoritesCityImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        favoritesCityImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
    }
}
