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
           tv.dataSource = self
           tv.delegate = self
           return tv
       }()

    private var favoritesPic = [FavoritedPictures]() {
         didSet {
             favoritesTableView.reloadData()
         }
     }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()

    }
    
    func loadData(){
        do {favoritesPic = try ImagePersistenceManager.manager.getImage()
            favoritesTableView.reloadData()
        } catch let error {
            print(error)
        }
    }
  func setupView() {
         favoritesTableView.dataSource = self
         favoritesTableView.delegate = self
     }

}

extension FavoriteWeatherVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesPic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorites = favoritesPic[indexPath.row]
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as! FavoritesCell
//        if let image = favorites.hits {
//            ImageHelper.shared.getImage(urlStr: image) {
//                (result) in
//                DispatchQueue.main.async {
//                    switch (result) {
//                    case .success(let picture):
//                        cell.favoritesCityImage.image = picture
//                    case .failure(let error):
//                        print (error)
//                    }
//                }
//            }
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 280
      }
    
}
/*

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var favoritedDetails = storyboard?.instantiateViewController(withIdentifier: "FavoriteDetailViewController") as! FavoriteDetailViewController
        
        favoritedDetails.favoriteDeets = favoritedPictures[indexPath.row]
        navigationController?.pushViewController(favoritedDetails, animated: true)
        
    }
   
}

*/
