//
//  MainViewModel.swift
//  WeatherGuru
//
//  Created by CM on 01/05/2023.
//

import Foundation
import UIKit
import CoreData

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
    
    func fetchSavedCities() -> [City] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<City>(entityName: "City")
        do {
            let savedCities = try context.fetch(fetchRequest)
            return savedCities
        } catch {
            print("Failed to fetch cities: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveCityToCoreData(city: String, key: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard let newCity = NSEntityDescription.insertNewObject(forEntityName: "City", into: context) as? City else { return }
        newCity.city = city
        newCity.key = key
        
        do {
            try context.save()
        } catch {func saveCityToCoreData(city: String, key: String) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            let newCity = NSEntityDescription.insertNewObject(forEntityName: "City", into: context) as! City
            newCity.city = city
            newCity.key = key
            
            do {
                try context.save()
            } catch {
                print("Failed to save city: \(error.localizedDescription)")
            }
        }
            
            print("Failed to save city: \(error.localizedDescription)")
        }
    }
}
