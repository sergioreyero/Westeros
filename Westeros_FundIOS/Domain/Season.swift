//
//  Season.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 03/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import UIKit

typealias Chapters = Set<Episode>

// MARK: - Season
final class Season {
    let name: String
    let startDate: Date
    private var _chapters: Chapters
    
    init(name: String, startDate: Date){
        self.name = name
        self.startDate = startDate
        _chapters = Chapters()
    }
}

extension Season {
    var numberOfEpisodes: Int {
        return _chapters.count
    }
    
    var sortedEpisodes: [Episode] {
        return _chapters.sorted(by: {$0.launchDate.timeIntervalSinceNow < $1.launchDate.timeIntervalSinceNow})
    }
    
    
    
    func add(episode: Episode) {
        guard episode.season == self else {
            return
        }
        _chapters.insert(episode)
    }
    
    // TODO: Revisar implementación más generica para usar con otros Date
    func parse(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
}


extension Season {
    var proxyForEquality: String {
        return "\(name) \(startDate)"
    }
    
    var proxyForComparison: String {
        return name
    }
    
    var custom: CustomStringConvertible {
        return "\(name) / \(_chapters.count) episodes / Date: \(parse(date: startDate))"
    }
}

extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}













