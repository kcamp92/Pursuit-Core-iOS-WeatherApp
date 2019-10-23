//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class WeatherAPIClient {
    
    private init() {}
    static let shared = WeatherAPIClient()
    
    func getWeather(latLong: String,completionHandler: @escaping (Result<[WeatherData], AppError>)-> Void){
        
        let URLString = "https://api.darksky.net/forecast/\(Secrets.key)/\(latLong)"
        guard let url = URL(string: URLString) else {completionHandler(.failure(AppError.badURL))
            return 
        }
    NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (results)in
        switch results {
        case .failure(let error):
            completionHandler(.failure(error))
        case .success(let data):
            do {
        let weatherDecoded = try JSONDecoder().decode([WeatherData].self, from: data)
                completionHandler(.success(weatherDecoded))
            } catch {
        completionHandler(.failure(AppError.couldNotParseJSON(rawError:error)))
                        }
                    }
                }
            }
        }
