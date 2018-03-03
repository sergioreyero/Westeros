//
//  SeasonTests.swift
//  Westeros_FundIOSTests
//
//  Created by Sergio Reyero on 03/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import XCTest
@testable import Westeros_FundIOS

class SeasonTests: XCTestCase {
    
    var season1: Season!
    var season2: Season!
    var season3: Season!
    
    var e1s1: Episode!
    var e1s2: Episode!
    var e1s3: Episode!
    
    override func setUp() {
        super.setUp()
        
        season1 = Season(name: "Season 1", startDate: Date(timeIntervalSinceReferenceDate: 324700000))
        season2 = Season(name: "Season 2", startDate: Date(timeIntervalSinceNow: -200000))
        season3 = Season(name: "Season 3", startDate: Date(timeIntervalSinceNow: -100000))
        
        e1s1 = Episode(title: "Winter Is Coming", launchDate: Date(timeIntervalSinceReferenceDate: 324700000), season: season1)
        e1s2 = Episode(title: "Winter Is Coming 2", launchDate: Date(timeIntervalSinceReferenceDate: 326700000), season: season2)
        e1s3 = Episode(title: "Winter Is Coming 3", launchDate: Date(timeIntervalSinceReferenceDate: 328700000), season: season3)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
        XCTAssertNotNil(season2)
    }
    
    func testAddEpisodes() {
        XCTAssertEqual(season1.numberOfEpisodes, 0)
        
        season1.add(episode: e1s1)
        XCTAssertEqual(season1.numberOfEpisodes, 1)
        
        season1.add(episode: e1s2)
        XCTAssertEqual(season1.numberOfEpisodes, 1)
        XCTAssertEqual(season2.numberOfEpisodes, 0)
        
        season2.add(episode: e1s2)
        XCTAssertEqual(season2.numberOfEpisodes, 1)
    }
    
    func testSeasonEquality() {
        XCTAssertEqual(season1, season1)
        
        let season1Copy = Season(name: "Season 1", startDate: Date(timeIntervalSinceReferenceDate: 324700000))
        XCTAssertEqual(season1, season1Copy)
        
        XCTAssertNotEqual(season1, season2)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonComparison() {
        XCTAssertGreaterThan(season2, season1)
    }
    
    func testSeasonCustomString() {
        let customString = "Season 1 / 0 episodes / Date: 17-04-2011"

        XCTAssertEqual(customString, String(describing: season1.custom))
    }
}
