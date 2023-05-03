//
//  WeatherDetailViewModel.swift
//  WeatherGuru
//
//  Created by CM on 01/05/2023.
//

import Foundation
import UIKit

class WeatherDetailViewModel {
    private var dailyModel: DailyWeatherModel?
    
    init(dailyModel: DailyWeatherModel?) {
        self.dailyModel = dailyModel
    }
    
    func getWeatherIconName() -> String {
        return dailyModel?.first?.weatherIcon?.description  ?? "image_not_found"
    }
    
    func getFormattedDate() -> String? {
        if let effectiveDate = dailyModel?.first?.localObservationDate {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            let day = dayFormatter.string(from: effectiveDate)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            let date = dateFormatter.string(from: effectiveDate)
            return "\(day) | \(date)"
        }
        return nil
    }
    
    func getTemperature() -> String? {
        if let temperatureValue = dailyModel?.first?.temperature?.metric?.value {
            return "\(temperatureValue)°"
        }
        return nil
    }
    
    func getTemperatureColor() -> UIColor {
        if let temperatureValue = dailyModel?.first?.temperature?.metric?.value {
            if temperatureValue < 10.0 {
                return .blue
            } else if temperatureValue >= 10.0 && temperatureValue <= 20.0 {
                return .black
            } else {
                return .red
            }
        }
        return .clear
    }
    
    func getWindSpeed() -> String {
        if let windValue = dailyModel?.first?.wind?.speed?.metric {
            return "\(NSLocalizedString("wind", comment: "")) \(windValue.value ?? 0.0) \(windValue.unit ?? "")"
        }
        return "\(NSLocalizedString("wind", comment: "")) N/A"
    }
    
    func getHumidity() -> String {
        if let humidityValue = dailyModel?.first?.relativeHumidity {
            return "\(NSLocalizedString("humidity", comment: "")) \(humidityValue) %"
        }
        return "\(NSLocalizedString("humidity", comment: "")) N/A"
    }
    
    func getPressure() -> String {
        if let pressureValue = dailyModel?.first?.pressure?.metric {
            return "\(NSLocalizedString("pressure", comment: "")) \(pressureValue.value ?? 0.0) \(pressureValue.unit ?? "")"
        }
        return "\(NSLocalizedString("pressure", comment: "")) N/A"
    }
}
