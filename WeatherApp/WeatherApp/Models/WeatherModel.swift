//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

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
}

//"daily": {
//"summary": "No precipitation throughout the week, with high temperatures rising to 74°F on Tuesday.",
//"icon": "clear-day",
//"data": [
//    {
//        "time": 1571209200,
//        "summary": "Mostly cloudy throughout the day.",
//        "icon": "partly-cloudy-day",
//        "sunriseTime": 1571235614,
//        "sunsetTime": 1571275945,
//        "moonPhase": 0.6,
//        "precipIntensity": 0.0007,
//        "precipIntensityMax": 0.0064,
//        "precipIntensityMaxTime": 1571292000,
//        "precipProbability": 0.14,
//        "precipType": "rain",
//        "temperatureHigh": 61.09,
//        "temperatureHighTime": 1571263200,
//        "temperatureLow": 53.8,
//        "temperatureLowTime": 1571324400,
//        "apparentTemperatureHigh": 60.42,
//        "apparentTemperatureHighTime": 1571263200,
//        "apparentTemperatureLow": 54.45,
//        "apparentTemperatureLowTime": 1571324400,
//        "dewPoint": 47.64,
//        "humidity": 0.72,
//        "pressure": 1015.07,
//        "windSpeed": 4.93,
//        "windGust": 15.27,
//        "windGustTime": 1571274000,
//        "windBearing": 247,
//        "cloudCover": 0.52,
//        "uvIndex": 4,
//        "uvIndexTime": 1571256000,
//        "visibility": 9.341,
//        "ozone": 277.3,
//        "temperatureMin": 52.14,
//        "temperatureMinTime": 1571234400,
//        "temperatureMax": 61.09,
//        "temperatureMaxTime": 1571263200,
//        "apparentTemperatureMin": 52.79,
//        "apparentTemperatureMinTime": 1571234400,
//        "apparentTemperatureMax": 60.42,
//        "apparentTemperatureMaxTime": 1571263200
//    }
