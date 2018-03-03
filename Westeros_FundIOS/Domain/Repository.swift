//
//  Repository.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 03/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import Foundation

final class Repository {
    static let local = LocalFactory()
}

protocol SeasonFactory {
    var seasons: [Season] { get }
}

final class LocalFactory: SeasonFactory {
    
    var seasons: [Season] {
        // TODO: Tratamiento de Date - String-->Date
        //17-04-2011
        let season1 = Season(name: "Season 1", startDate: Date(timeIntervalSinceReferenceDate: 324700000))
        let e1s1 = Episode(title: "Winter Is Coming", launchDate: Date(timeIntervalSinceReferenceDate: 324700000), season: season1)
        let e2s1 = Episode(title: "The Kingsroad", launchDate: Date(timeIntervalSinceReferenceDate: 324750000), season: season1)
        
        //01-04-2012
        let season2 = Season(name: "Season 2", startDate: Date(timeIntervalSinceReferenceDate: 354700000))
        let e1s2 = Episode(title: "The North Remembers", launchDate: Date(timeIntervalSinceReferenceDate: 354700000), season: season1)
        let e2s2 = Episode(title: "The Night Lands", launchDate: Date(timeIntervalSinceReferenceDate: 354750000), season: season1)
        
        //31-03-2013
        let season3 = Season(name: "Season 3", startDate: Date(timeIntervalSinceReferenceDate: 384700000))
        let e1s3 = Episode(title: "Valar Dohaeris", launchDate: Date(timeIntervalSinceReferenceDate: 384700000), season: season1)
        let e2s3 = Episode(title: "Dark Wings, Dark Words", launchDate: Date(timeIntervalSinceReferenceDate: 384750000), season: season1)

        
        season1.add(episode: e1s1)
        season1.add(episode: e2s1)
        
        season2.add(episode: e1s2)
        season2.add(episode: e2s2)
        
        season3.add(episode: e1s3)
        season3.add(episode: e2s3)
        
        return [season1, season2, season3]
    }
}
