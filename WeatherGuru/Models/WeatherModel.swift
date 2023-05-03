//
//  WeatherModel.swift
//  WeatherGuru
//
//  Created by CM on 29/04/2023.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable, Equatable {
    let headline: Headline?
    let dailyForecasts: [DailyForecast]?
    
    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }
}

// MARK: - DailyForecast
struct DailyForecast: Codable, Equatable {
    let date: Date?
    let epochDate: Int?
    let temperature: Temperature?
    let day: Day?
    let night: Night?
    let sources: [String]?
    let mobileLink: String?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case epochDate = "EpochDate"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
        case sources = "Sources"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}


// MARK: - Day
struct Day: Codable, Equatable {
    let icon: Int?
    let iconPhrase: String?
    let hasPrecipitation: Bool?
    
    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
    }
}

// MARK: - Night
struct Night: Codable, Equatable {
    let icon: Int?
    let iconPhrase: String?
    let hasPrecipitation: Bool?
    let precipitationType: String?
    let precipitationIntensity: String?

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case precipitationIntensity = "PrecipitationIntensity"
    }
}

// MARK: - Temperature
struct Temperature: Codable, Equatable {
    let minimum: Imum?
    let maximum: Imum?

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - Imum
struct Imum: Codable, Equatable {
    let value: Double?
    let unit: Unit?
    let unitType: Int?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

enum Unit: String, Codable, Equatable {
    case c = "C"
}

// MARK: - Headline
struct Headline: Codable, Equatable {
    let effectiveDate: Date?
    let effectiveEpochDate: Int?
    let severity: Int?
    let text: String?
    let category: String?
    let endDate: Date?
    let endEpochDate: Int?
    let mobileLink: String?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
        case endDate = "EndDate"
        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}
