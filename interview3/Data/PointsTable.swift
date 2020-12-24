//
//  PointsTable.swift
//  interview3
//
//  Created by mengjiao on 12/22/20.
//

import Foundation

struct PointsTable: Codable {
    let welcomeDescription: String
    let point: Int

    enum CodingKeys: String, CodingKey {
        case welcomeDescription = "Description"
        case point = "Point"
    }
}
