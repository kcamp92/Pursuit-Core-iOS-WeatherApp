//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/18/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var cityForecastDateLabel: UILabel = {
          let label = UILabel()
          label.textAlignment = .center
          label.font = UIFont(name: "Marker Felt", size: 30.0)
          label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
          label.backgroundColor = .systemGreen
          return label
          }()
      
    
    lazy var cityImage: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 4
        iv.layer.borderColor = UIColor.blue.cgColor
        return iv
      }()
    
    lazy var descriptionTextView: UITextView = {
        let label = UITextView()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 30.0)
        label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        label.backgroundColor = .systemGreen
        return label
           }()
    
//    lazy var saveButton: UIBarButtonItem = {
//        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: <#T##Selector?#>)
//
//
//    }()
//
    

    override func viewDidLoad() {
        super.viewDidLoad()
       // navigationItem.rightBarButtonItem = saveButton

        // Do any additional setup after loading the view.
    }
  

}
