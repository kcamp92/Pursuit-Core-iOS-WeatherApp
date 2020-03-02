//
//  FavoriteWeatherVC.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

private let cellIdentifier = "FavoritesCell"

class FavoriteWeatherVC: UIViewController {
    
    lazy var favoritesTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.register(FavoritesCell.self, forCellReuseIdentifier: cellIdentifier)
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    private var favoritesPic = [FavoritedImages]() {
        didSet {
            favoritesTableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadData()
        setupConstraints()
        
    }
    
    func loadData(){
        do {favoritesPic = try ImagePersistenceManager.manager.getImage()
            favoritesTableView.reloadData()
        } catch let error {
            print("\(error)")
        }
    }
    
    
    func setupConstraints(){
        view.addSubview(favoritesTableView)
        favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        favoritesTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        favoritesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        favoritesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        favoritesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
}


extension FavoriteWeatherVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesPic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorites = favoritesPic[indexPath.row]
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as! FavoritesCell
        cell.favoritesCityImage.image = UIImage(data: favorites.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
