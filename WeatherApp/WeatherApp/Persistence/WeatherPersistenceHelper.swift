//
//  WeatherPersistenceHelper.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct ImagePersistenceManager {
    
static let manager = ImagePersistenceManager()
    
private let persistenceHelper = PersistenceHelper<FavoritedImages>(fileName: "image.plist")
    
func saveImage(image: FavoritedImages) throws {
        try persistenceHelper.save(newElement: image)
    }
    
func getImage() throws -> [FavoritedImages] {
    return try persistenceHelper.getObjects()
    }
     private init (){}
}
 

