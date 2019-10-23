//
//  UserDefaults.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/23/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class UserDefaultsWrapper {
    
    static let manager = UserDefaultsWrapper()
    
    func store(zipCode: String){
        UserDefaults.standard.set(zipCode, forKey: zipCodeKey)
    }
    
    func getZipCode() -> String? {
        return UserDefaults.standard.value(forKey: zipCodeKey) as? String
    }
    
    private init() {}
       
       private let zipCodeKey = "zipCode"
     
}
