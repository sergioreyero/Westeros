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
    typealias Filter = (Season) -> Bool
    
    var seasons: [Season] { get }
    
    func seasons(filteredBy: Filter) -> [Season]
}

final class LocalFactory: SeasonFactory {
    
    var seasons: [Season] {
        // TODO: Tratamiento de Date - String-->Date
        //17-04-2011
        let season1 = Season(name: "Season 1", startDate: Date(timeIntervalSinceReferenceDate: 324700000))
        let e1s1 = Episode(title: "Winter Is Coming", launchDate: Date(timeIntervalSinceReferenceDate: 324700000), season: season1)
        let e2s1 = Episode(title: "The Kingsroad", launchDate: Date(timeIntervalSinceReferenceDate: 324750000), season: season1)
        let e3s1 = Episode(title: "Lord Snow", launchDate: Date(timeIntervalSinceReferenceDate: 324750000), season: season1)
        
        //01-04-2012
        let season2 = Season(name: "Season 2", startDate: Date(timeIntervalSinceReferenceDate: 354700000))
        let e1s2 = Episode(title: "The North Remembers", launchDate: Date(timeIntervalSinceReferenceDate: 354700000), season: season2)
        let e2s2 = Episode(title: "The Night Lands", launchDate: Date(timeIntervalSinceReferenceDate: 354750000), season: season2)
        
        //31-03-2013
        let season3 = Season(name: "Season 3", startDate: Date(timeIntervalSinceReferenceDate: 384700000))
        let e1s3 = Episode(title: "Valar Dohaeris", launchDate: Date(timeIntervalSinceReferenceDate: 384700000), season: season3)
        let e2s3 = Episode(title: "Dark Wings, Dark Words", launchDate: Date(timeIntervalSinceReferenceDate: 384750000), season: season3)
        
        //06-04-2014
        let season4 = Season(name: "Season 4", startDate: Date(timeIntervalSinceReferenceDate: 414700000))
        let e1s4 = Episode(title: "Two Swords", launchDate: Date(timeIntervalSinceReferenceDate: 414700000), season: season4)
        let e2s4 = Episode(title: "The Lion and the Rose", launchDate: Date(timeIntervalSinceReferenceDate: 384750000), season: season4)
        
        //12-04-2015
        let season5 = Season(name: "Season 5", startDate: Date(timeIntervalSinceReferenceDate: 434700000))
        let e1s5 = Episode(title: "The Wars to Come", launchDate: Date(timeIntervalSinceReferenceDate: 384700000), season: season5)
        let e2s5 = Episode(title: "The House of Black and White", launchDate: Date(timeIntervalSinceReferenceDate: 384750000), season: season5)
        
        //24-04-2016
        let season6 = Season(name: "Season 6", startDate: Date(timeIntervalSinceReferenceDate: 454700000))
        let e1s6 = Episode(title: "The Red Woman", launchDate: Date(timeIntervalSinceReferenceDate: 384700000), season: season6)
        let e2s6 = Episode(title: "Home", launchDate: Date(timeIntervalSinceReferenceDate: 384750000), season: season6)
        
        //16-07-2017
        let season7 = Season(name: "Season 7", startDate: Date(timeIntervalSinceReferenceDate: 474700000))
        let e1s7 = Episode(title: "Dragonstone", launchDate: Date(timeIntervalSinceReferenceDate: 384700000), season: season7)
        let e2s7 = Episode(title: "Stormborn", launchDate: Date(timeIntervalSinceReferenceDate: 384750000), season: season7)
        
        
        season1.add(episode: e1s1)
        season1.add(episode: e2s1)
        season1.add(episode: e3s1)
        
        season2.add(episode: e1s2)
        season2.add(episode: e2s2)
        
        season3.add(episode: e1s3)
        season3.add(episode: e2s3)
        
        season4.add(episode: e1s4)
        season4.add(episode: e2s4)
        
        season5.add(episode: e1s5)
        season5.add(episode: e2s5)
        
        season6.add(episode: e1s6)
        season6.add(episode: e2s6)
        
        season7.add(episode: e1s7)
        season7.add(episode: e2s7)
        
        return [season1, season2, season3, season4, season5, season6, season7]
    }
    
    func seasons(filteredBy: Filter) -> [Season] {
        return Repository.local.seasons.filter(filteredBy)
    }
}
