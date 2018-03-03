//
//  EpisodeTests.swift
//  Westeros_FundIOSTests
//
//  Created by Sergio Reyero on 03/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import XCTest
@testable import Westeros_FundIOS

class EpisodeTests: XCTestCase {
    
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
    
    func testEpisodeExistence() {
        XCTAssertNotNil(e1s1)
        XCTAssertNotNil(e1s2)
    }
    
    func testEpisodeEquality() {
        XCTAssertEqual(e1s1, e1s1)
        
        let episode2Copy = Episode(title: "Winter Is Coming 2", launchDate: Date(timeIntervalSinceReferenceDate: 326700000), season: season2)
        XCTAssertEqual(e1s2, episode2Copy)
        
        XCTAssertNotEqual(e1s2, e1s3)
    }
    
    func testEpisodeHashable() {
        XCTAssertNotNil(e1s1.hashValue)
    }
    
    func testEpisodeComparison() {
        XCTAssertLessThan(e1s1, e1s2)
    }
    
    func testEpisodeCustomString() {
        let customString = "Winter Is Coming 3 / 02-06-2011"
        
        XCTAssertEqual(customString, String(describing: e1s3.custom))
    }
}
