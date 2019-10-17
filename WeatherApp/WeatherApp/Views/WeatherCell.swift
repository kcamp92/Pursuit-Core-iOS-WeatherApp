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
      
    lazy var dateLabel: UILabel = {
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
        setupDateLabel()
        setupIconImage()
        setupHighLabel()
        setupLowLabel()
         }
        
  // MARK:- Constraint Set-Up
    
    private func setupDateLabel(){
    contentView.addSubview(dateLabel)
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
    dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
    dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
    dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
       }
    
    private func setupIconImage(){
        contentView.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
        iconImage.topAnchor.constraint(equalTo: contentView.topAnchor),
        iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        iconImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
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
    
    
required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
                   }
    }

