//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    lazy var iconImage: UIImageView = {
        let image = UIImageView()
        return image
      }()
      
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        return label
        }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        return label
           }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        return label
           }()
    

    override init(frame: CGRect) {
        super.init(frame:frame)
         setupIconImage()
         }
    required init?(coder: NSCoder) {
                   fatalError("init(coder:) has not been implemented")
               }
    
  // MARK:- Constraint Set-Up
    
    private func setupIconImage(){
        contentView.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
        iconImage.topAnchor.constraint(equalTo: contentView.topAnchor),
        iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        iconImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
           }
    
    
    
    
    
required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
                   }
    }

