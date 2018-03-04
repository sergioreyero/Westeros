//
//  Parser.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 03/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import Foundation

let formatter = DateFormatter()

extension String {
    func parseToDate(string: String) -> Date {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let DateArray = string.components(separatedBy: "/")
        let components = NSDateComponents()
        components.year = Int(DateArray[2])!
        components.month = Int(DateArray[1])!
        components.day = Int(DateArray[0])!
        components.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let date = calendar?.date(from: components as DateComponents)
        
        return date!
    }
}

extension Date {
    func parseToString(date: Date) -> String {
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
}
