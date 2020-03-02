//
//  FavoritesModel.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct FavoritedPictures: Codable {
    let hits: [Hit]
}

struct Hit: Codable {
    let largeImageURL: String?
}
