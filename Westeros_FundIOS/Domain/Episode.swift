//
//  Episode.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 03/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import Foundation

final class Episode {
    let title: String
    let launchDate: Date
    weak var season: Season?
    
    init(title: String, launchDate: Date, season: Season){
        self.title = title
        self.launchDate = launchDate
        self.season = season
    }
    
    // TODO: Revisar implementación más generica para usar con otros Date
    func parse(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
}

extension Episode {
    var proxyForEquality: String {
        return "\(title) \(launchDate) \(season!.name)"
    }
    
    var proxyForComparison: String {
        return title.uppercased()
    }
    
    var custom: CustomStringConvertible {
        return "\(title) / \(parse(date: launchDate))"
    }
}

extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Episode: Comparable {
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
