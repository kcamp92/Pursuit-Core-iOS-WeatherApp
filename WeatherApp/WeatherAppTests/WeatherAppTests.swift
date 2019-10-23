//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Krystal Campbell on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import XCTest


class WeatherAppTests: XCTestCase {
    @testable import WeatherApp
    
    private func getWeatherData() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "Weather", ofType: "json")
            else {
                fatalError("Weather.json file not found")
        }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("could not find file: \(jsonError)")
        }
    }

  
    func testWeatherDataLoad() {
        let weather = Weather.getWeatherData()
        XCTAssert(weather.count > 0, "donde es data?")
            
    }


    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
