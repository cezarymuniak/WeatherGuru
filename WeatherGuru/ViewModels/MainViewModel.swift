//
//  MainViewModel.swift
//  WeatherGuru
//
//  Created by CM on 01/05/2023.
//

import Foundation

class MainViewModel {
    private let weatherAPI = WeatherAPI()
    private(set) var locations: [Location] = []
    
    var locationsCount: Int {
        return locations.count
    }
    func searchLocations(_ query: String, completion: @escaping (Result<[Location], Error>) -> Void) {
        weatherAPI.searchLocations(query: query) { result in
            switch result {
            case .success(let locations):
                self.locations = locations
                completion(.success(locations))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchWeather(_ locationKey: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        weatherAPI.getCurrentWeather(locationKey: locationKey) { result in
            switch result {
            case .success(let weather):
                completion(.success(weather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func location(at index: Int) -> Location {
        return locations[index]
    }
    
    func searchCurrentWeather(_ locationKey: String, completion: @escaping (Result<DailyWeatherModel, Error>) -> Void) {
        weatherAPI.fetchDailyWeatherData(locationKey: locationKey) { result in
            switch result {
            case .success(let weather):
                completion(.success(weather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
