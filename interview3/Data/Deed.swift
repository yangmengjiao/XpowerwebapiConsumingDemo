//
//  Deeds.swift
//  interview3
//
//  Created by mengjiao on 12/23/20.
//

import Foundation

struct Deed: Codable {
    let Username: String
    let Deed: String
    let Date: String
    init(_ userName: String, _ deed: String) {
        self.Username = userName
        self.Deed = deed
        
        self.Date = Foundation.Date().currentDateString
        print(self.Date)
    }
}

extension Date {
    var currentDateString: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = Constant.dateFormat
        return  formatter.string(from: date)
    }
}
