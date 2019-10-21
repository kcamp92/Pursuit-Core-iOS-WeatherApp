//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
import UIKit

struct Weather: Codable {
    let daily: Daily
    
enum JSONError: Error {
    case decodingError(Error)
       }
       
    static func getWeatherData() -> [WeatherData] {
        guard let fileName = Bundle.main.path(forResource: "Weather", ofType: "json")
            else {fatalError()}
        let fileURL = URL(fileURLWithPath: fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let weather = try
                JSONDecoder().decode(Weather.self, from: data)
            return weather.daily.data
        } catch {
            fatalError("\(error)")
        }
    }
}


struct Daily: Codable {
    let data: [WeatherData]
}

struct WeatherData: Codable {
    let time: Int
    let summary: String
    let icon: String
    let temperatureLow: Double
    let temperatureHigh: Double
    let sunriseTime: Int
    let sunsetTime: Int
    let windSpeed: Double
    let precipProbability: Double
    
    
    func getSpecificTimeFromTime(time:Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        let testDate = dateFormatter.string(from: date as Date)
        return testDate.components(separatedBy: " at")[1]
    }
    
    func returnPictureBasedOnIcon(icon:String) -> UIImage {
        switch icon {
        case "rain":
            return UIImage(named: "rain")!
        case "cloudy":
            return UIImage(named: "cloudy")!
        case "partly-cloudy-night":
            return UIImage(named: "pcloudyn")!
        case "clear-day":
            return UIImage(named: "clear")!
        case "clear-night":
            return UIImage(named:"clearn")!
        case "partly-cloudy-day":
            return UIImage(named:"pcloudy" )!
        case "snow":
            return UIImage(named: "snow")!
        case "sleet":
            return UIImage(named: "sleet")!
        case "wind":
            return UIImage(named: "wind")!
        case "fog":
            return UIImage(named:"fog")!
        default:
            return UIImage(named: "image")!
        }
    }
}


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
