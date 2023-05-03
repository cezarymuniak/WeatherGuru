//
//  WeatherAPI.swift
//  WeatherGuru
//
//  Created by CM on 30/04/2023.
//

import Foundation

struct WeatherAPI {
    let apiKey = "m1VLvce9NfsDPHWNo3NGcG9Ax73GfS3D"
    let baseUrl = "https://dataservice.accuweather.com/"
    let locationEndpoint = "locations/v1/cities/search"
    let locationsEndpoint = "locations/v1/cities/autocomplete"
    
    
    func searchLocations(query: String, completion: @escaping (Result<Locations, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/locations/v1/cities/autocomplete?apikey=\(apiKey)&q=\(query)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let locations = try decoder.decode(Locations.self, from: data)
                completion(.success(locations))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTommorowWeather(locationKey: String, completionHandler: @escaping (Result<WeatherModel, Error>) -> Void) {
        let urlString = "\(baseUrl)/forecasts/v1/daily/5day/\(locationKey)?apikey=\(apiKey)&metric=true"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let weatherModel = try decoder.decode(WeatherModel.self, from: data)
                completionHandler(.success(weatherModel))
            } catch {
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func fetchDailyWeatherData(locationKey: String, completionHandler: @escaping (Result<DailyWeatherModel, Error>) -> Void) {
        let urlString = "\(baseUrl)/currentconditions/v1/\(locationKey)?apikey=\(apiKey)&details=true"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(NSError(domain: "", code: 100, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NSError(domain: "", code: 101, userInfo: nil)))
                return
            }
            
            do {
                let dailyModel = try JSONDecoder().decode(DailyWeatherModel.self, from: data)
                completionHandler(.success(dailyModel))
            } catch {
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
}
