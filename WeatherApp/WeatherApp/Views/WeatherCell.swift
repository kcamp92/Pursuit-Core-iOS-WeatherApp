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
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 4
        iv.layer.borderColor = UIColor.black.cgColor
        return iv
      }()
      
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 20.0)
        label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        label.backgroundColor = .systemGreen
        return label
        }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 30.0)
        label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        label.backgroundColor = .systemGreen
        return label
           }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 30.0)
        label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        label.backgroundColor = .systemGreen
        return label
           }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
                       }

    override init(frame: CGRect) {
        super.init(frame:frame)
        setupDateLabel()
        setupIconImage()
        setupHighLabel()
        setupLowLabel()
         }
        
  // MARK:- Constraint Set-Up
    
    private func setupDateLabel(){
    contentView.addSubview(dateLabel)
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    
    dateLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    dateLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
       }
    
    private func setupIconImage(){
        contentView.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        iconImage.topAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        iconImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
           }
    
    
    private func setupHighLabel(){
    contentView.addSubview(highLabel)
    highLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
    highLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
    highLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
    highLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
       }
    private func setupLowLabel(){
    contentView.addSubview(lowLabel)
    lowLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
    lowLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
    lowLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
    lowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
    lowLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
       }
    
    
    }

