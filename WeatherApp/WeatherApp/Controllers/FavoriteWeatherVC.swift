//
//  FavoriteWeatherVC.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoriteWeatherVC: UIViewController {
    
    lazy var favoritesTableView: UITableView = {
           let tv = UITableView()
           tv.backgroundColor = .white
         //  tv.dataSource = self
          // tv.delegate = self
           return tv
       }()

    private var favorites = [FavoritedPictures]() {
         didSet {
             favoritesTableView.reloadData()
         }
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

  

}
