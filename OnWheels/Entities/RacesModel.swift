//
//  RaceModel.swift
//  OnWheels
//
//  Created by Veronika on 25.12.2022.
//

import Foundation

struct RaceResponse {
    let raceList: [RaceListElement]
}
extension RaceResponse: Decodable {
    private enum RaceResponseCodingKeys: CodingKey{
        case races
        case raceList
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RaceResponseCodingKeys.self)
        raceList = try container.decode([RaceListElement].self, forKey: .raceList)
    }
}

typealias RaceList = [RaceListElement]

struct RaceListElement: Codable {
    let creatorUserID: Int
    let name: String
    let location: Location
    let date: DateClass
    let raceListDescription: String
    let images, tags: [String]
    let members: [Int]
    let likes, views: Int

    enum CodingKeys: String, CodingKey {
        case creatorUserID = "creatorUserId"
        case name, location, date
        case raceListDescription = "description"
        case images, tags, members, likes, views
    }
}

struct OneRace: Codable {
    let creatorUserID: Int
    let name: String
    let location: Location
    let date: DateClass
    let oneRaceDescription: String
    let images, tags: [String]
    let members: [Int]
    let likes, views: Int

    enum OneRaceCodingKeys: String, CodingKey {
        case creatorUserID = "creatorUserId"
        case name, location, date
        case oneRaceDescription = "description"
        case images, tags, members, likes, views
    }
}

extension OneRace {
    init(from decoder: Decoder) throws {
        let oneRaceContainer = try decoder.container(keyedBy: OneRaceCodingKeys.self)
        creatorUserID = try oneRaceContainer.decode(Int.self, forKey: .creatorUserID)
        name = try oneRaceContainer.decode(String.self, forKey: .name)
        location = try oneRaceContainer.decode(Location.self, forKey: .location)
        date = try oneRaceContainer.decode(DateClass.self, forKey: .date)
        oneRaceDescription = try oneRaceContainer.decode(String.self, forKey: .oneRaceDescription)
        images = try oneRaceContainer.decode([String].self, forKey: .images)
        tags = try oneRaceContainer.decode([String].self, forKey: .tags)
        members = try oneRaceContainer.decode([Int].self, forKey: .members)
        likes = try oneRaceContainer.decode(Int.self, forKey: .likes)
        views = try oneRaceContainer.decode(Int.self, forKey: .views)
    }
}

// MARK: - DateClass
struct DateClass: Codable {
    let from, to: String
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double
}
