//
//  PictureAPIClient.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class PicturesAPIClient{
    
    private init() {}
    static let shared = PicturesAPIClient()

    func getWeather(searchTerm: String, completionHandler: @escaping (Result<[WeatherData], Error>)-> Void){

        let urlString = "https://pixabay.com/api/?key=13914646-74defb60eef565463557ca2e6&q=\(searchTerm.replacingOccurrences(of: "", with: "+"))"

        guard let url  = URL(string: urlString) else {
            completionHandler(.failure(AppError.badURL))
            return
        }

        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (results) in
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

