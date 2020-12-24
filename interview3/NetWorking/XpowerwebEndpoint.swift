//
//  XpowerwebEndpoint.swift
//  interview3
//
//  Created by mengjiao on 12/22/20.
//

import Foundation

/// Endpoint for Xpowerweb
/// base on requirements could add more enum case in the future
enum XpowerwebEndpoint: Endpoint {
    case CreateUserAccount
    case GetPointsTable
    case AddDeeds
    case GetTotalPoints(name: String)
    
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "xpowerwebapi20200430054944.azurewebsites.net"
        }
    }
    
    var path: String {
        switch self {
        case .CreateUserAccount:
            return "/api/User/CreateUserAccount"
        case .GetPointsTable:
            return "/api/Point/PointsTable"
        case .AddDeeds:
            return "/api/Point/Adddeeds"
        case .GetTotalPoints:
            return "/api/Point/GetDailyPoint"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .GetTotalPoints(let nameValue):
            return [URLQueryItem(name: "Username", value: nameValue)]
        default:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .CreateUserAccount:
            return "POST"
        case .GetPointsTable:
            return "GET"
        case .AddDeeds:
            return "POST"
        case .GetTotalPoints:
            return "POST"
        }
    }
}

