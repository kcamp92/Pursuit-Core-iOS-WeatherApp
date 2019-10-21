//
//  WeatherPersistenceHelper.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct ImagePersistenceManager {
    
    private init (){}
    
static let manager = ImagePersistenceManager()
private let persistenceHelper = PersistenceHelper<FavoritedPictures>(fileName: "image.plist")
    
func saveImage(image: FavoritedPictures) throws {
        try persistenceHelper.save(newElement: image)
    }
    
func getImage() throws -> [FavoritedPictures] {
        return try persistenceHelper.getObjects()
    }
}
 

