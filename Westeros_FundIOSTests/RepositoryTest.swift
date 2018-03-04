//
//  RepositoryTest.swift
//  Westeros_FundIOSTests
//
//  Created by Sergio Reyero on 04/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import XCTest
@testable import Westeros_FundIOS

class RepositoryTests: XCTestCase {
    
    var localSeason: [Season]!
    
    override func setUp() {
        super.setUp()
        localSeason = Repository.local.seasons
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLocalRepositoryCreation() {
        let local = Repository.local
        XCTAssertNotNil(local)
    }
    
    func testLocalRepositorySeasonsCreation() {
        XCTAssertNotNil(localSeason)
        XCTAssertEqual(localSeason.count, 7)
    }
    
    func testSeasonsFiltering() {
        let filter1 = Repository.local.seasons(filteredBy: { $0.numberOfEpisodes == 3 })
        XCTAssertEqual(filter1.count, 1)
        
        let filter2 = Repository.local.seasons(filteredBy: { $0.name.contains("3")})
        XCTAssertEqual(filter2.count, 1)
        
        let filter3 = Repository.local.seasons(filteredBy: { $0.name.contains("Seas")})
        XCTAssertEqual(filter3.count, 7)
    }
    
    func testReturnsHouseByTypeSafe() {
        let lannister = Repository.local.house(named: .Lannister)
        
        XCTAssertEqual(lannister?.name, "Lannister")
        XCTAssertNotEqual(lannister?.name, "Lanniister")
    }
}
