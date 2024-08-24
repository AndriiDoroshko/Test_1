//
//  CurrentWeatherData.swift
//  Test_1
//
//  Created by Andrey Doroshko on 8/23/24.
//

import Foundation

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let localtime: String
}

struct Current: Codable {
    let temp_c: Double
    let is_day: Int
    let condition: Condition
}

struct Condition: Codable {
    let text: String
    let icon: String
}

struct WeatherData: Codable {
    let location: Location
    let current: Current
}
