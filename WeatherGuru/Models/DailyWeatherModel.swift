//
//  DailyWeatherModel.swift
//  WeatherGuru
//
//  Created by CM on 01/05/2023.
//

import Foundation

// MARK: - DailyModelElement
struct DailyModelElement: Codable, Equatable {
    let localObservationDateTime: String?
    let epochTime: Int?
    let weatherText: String?
    let weatherIcon: Int?
    let hasPrecipitation: Bool?
    let precipitationType: JSONNull?
    let isDayTime: Bool?
    let temperature: ApparentTemperature?
    let realFeelTemperature: ApparentTemperature?
    let realFeelTemperatureShade: ApparentTemperature?
    let relativeHumidity: Int?
    let indoorRelativeHumidity: Int?
    let dewPoint: ApparentTemperature?
    let wind: Wind?
    let windGust: WindGust?
    let uvIndex: Int?
    let uvIndexText: String?
    let visibility: ApparentTemperature?
    let obstructionsToVisibility: String?
    let cloudCover: Int?
    let ceiling: ApparentTemperature?
    let pressure: ApparentTemperature?
    let pressureTendency: PressureTendency?
    let past24HourTemperatureDeparture: ApparentTemperature?
    let apparentTemperature: ApparentTemperature?
    let windChillTemperature: ApparentTemperature?
    let wetBulbTemperature: ApparentTemperature?
    let precip1Hr: ApparentTemperature?
    let precipitationSummary: [String: ApparentTemperature]?
    let temperatureSummary: TemperatureSummary?
    let mobileLink: String?
    let link: String?
    var localObservationDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: localObservationDateTime ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case localObservationDateTime = "LocalObservationDateTime"
        case epochTime = "EpochTime"
        case weatherText = "WeatherText"
        case weatherIcon = "WeatherIcon"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
        case realFeelTemperature = "RealFeelTemperature"
        case realFeelTemperatureShade = "RealFeelTemperatureShade"
        case relativeHumidity = "RelativeHumidity"
        case indoorRelativeHumidity = "IndoorRelativeHumidity"
        case dewPoint = "DewPoint"
        case wind = "Wind"
        case windGust = "WindGust"
        case uvIndex = "UVIndex"
        case uvIndexText = "UVIndexText"
        case visibility = "Visibility"
        case obstructionsToVisibility = "ObstructionsToVisibility"
        case cloudCover = "CloudCover"
        case ceiling = "Ceiling"
        case pressure = "Pressure"
        case pressureTendency = "PressureTendency"
        case past24HourTemperatureDeparture = "Past24HourTemperatureDeparture"
        case apparentTemperature = "ApparentTemperature"
        case windChillTemperature = "WindChillTemperature"
        case wetBulbTemperature = "WetBulbTemperature"
        case precip1Hr = "Precip1hr"
        case precipitationSummary = "PrecipitationSummary"
        case temperatureSummary = "TemperatureSummary"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

// MARK: - ApparentTemperature
struct ApparentTemperature: Codable, Equatable {
    let metric: Imperial?
    let imperial: Imperial?
    
    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

// MARK: - Imperial
struct Imperial: Codable, Equatable {
    let value: Double?
    let unit: String?
    let unitType: Int?
    let phrase: String?
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
        case phrase = "Phrase"
    }
}
// MARK: - PressureTendency
struct PressureTendency: Codable, Equatable {
    let localizedText: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case localizedText = "LocalizedText"
        case code = "Code"
    }
}
// MARK: - TemperatureSummary
struct TemperatureSummary: Codable, Equatable {
    let past6HourRange: PastHourRange?
    let past12HourRange: PastHourRange?
    let past24HourRange: PastHourRange?
    
    enum CodingKeys: String, CodingKey {
        case past6HourRange = "Past6HourRange"
        case past12HourRange = "Past12HourRange"
        case past24HourRange = "Past24HourRange"
    }
}

// MARK: - PastHourRange
struct PastHourRange: Codable, Equatable {
    let minimum: ApparentTemperature?
    let maximum: ApparentTemperature?
    
    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - Wind
struct Wind: Codable, Equatable {
    let direction: Direction?
    let speed: ApparentTemperature?
    
    enum CodingKeys: String, CodingKey {
        case direction = "Direction"
        case speed = "Speed"
    }
}

// MARK: - Direction
struct Direction: Codable, Equatable {
    let degrees: Int?
    let localized: String?
    let english: String?
    
    enum CodingKeys: String, CodingKey {
        case degrees = "Degrees"
        case localized = "Localized"
        case english = "English"
    }
}

// MARK: - WindGust
struct WindGust: Codable, Equatable {
    let speed: ApparentTemperature?
    
    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
    }
}

typealias DailyWeatherModel = [DailyModelElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        // No-op
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
