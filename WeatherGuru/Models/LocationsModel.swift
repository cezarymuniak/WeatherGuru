//
//  LocationsModel.swift
//  WeatherGuru
//
//  Created by CM on 30/04/2023.
//

import Foundation

// MARK: - Location
struct Location: Codable, Equatable {
    let version: Int?
    let key: String?
    let type: TypeEnum?
    let rank: Int?
    let localizedName: String?
    let country: AdministrativeArea?
    let administrativeArea: AdministrativeArea?
    
    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
    }
}

// MARK: - AdministrativeArea
struct AdministrativeArea: Codable, Equatable {
    let id: String?
    let localizedName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
    }
}

enum TypeEnum: String, Codable, Equatable {
    case city = "City"
}

typealias Locations = [Location]
