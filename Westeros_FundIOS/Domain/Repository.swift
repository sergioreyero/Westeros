//
//  Repository.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 03/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

// TODO: Revisar implementación más generica para usar con otros Date
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

protocol SeasonFactory {
    typealias FilterSeason = (Season) -> Bool
    
    var seasons: [Season] { get }
    
    func seasons(filteredBy: FilterSeason) -> [Season]
}

final class LocalFactory{}

extension LocalFactory: SeasonFactory {
    
    var seasons: [Season] {
        // TODO: Tratamiento de Date - String-->Date
        let season1 = Season(name: "Season 1", startDate: parseToDate(string: "17/04/2011"))
        let e1s1 = Episode(title: "Winter Is Coming", launchDate: parseToDate(string: "17/04/2011"), season: season1)
        let e2s1 = Episode(title: "The Kingsroad", launchDate: parseToDate(string: "24/04/2011"), season: season1)
        let e3s1 = Episode(title: "Lord Snow", launchDate: parseToDate(string: "30/04/2011"), season: season1)
        
        let season2 = Season(name: "Season 2", startDate: parseToDate(string: "01/04/2012"))
        let e1s2 = Episode(title: "The North Remembers", launchDate: parseToDate(string: "01/04/2012"), season: season2)
        let e2s2 = Episode(title: "The Night Lands", launchDate: parseToDate(string: "08/04/2012"), season: season2)
        
        let season3 = Season(name: "Season 3", startDate: parseToDate(string: "31/03/2013"))
        let e1s3 = Episode(title: "Valar Dohaeris", launchDate: parseToDate(string: "31/03/2013"), season: season3)
        let e2s3 = Episode(title: "Dark Wings, Dark Words", launchDate: parseToDate(string: "07/04/2013"), season: season3)
        
        let season4 = Season(name: "Season 4", startDate: parseToDate(string: "06/04/2014"))
        let e1s4 = Episode(title: "Two Swords", launchDate: parseToDate(string: "06/04/2014"), season: season4)
        let e2s4 = Episode(title: "The Lion and the Rose", launchDate: parseToDate(string: "13/04/2014"), season: season4)
        
        let season5 = Season(name: "Season 5", startDate: parseToDate(string: "12/04/2015"))
        let e1s5 = Episode(title: "The Wars to Come", launchDate: parseToDate(string: "12/04/2015"), season: season5)
        let e2s5 = Episode(title: "The House of Black and White", launchDate: parseToDate(string: "19/04/2015"), season: season5)
        
        let season6 = Season(name: "Season 6", startDate: parseToDate(string: "24/04/2016"))
        let e1s6 = Episode(title: "The Red Woman", launchDate: parseToDate(string: "24/04/2016"), season: season6)
        let e2s6 = Episode(title: "Home", launchDate: parseToDate(string: "01/05/2016"), season: season6)
        
        let season7 = Season(name: "Season 7", startDate: parseToDate(string: "16/07/2017"))
        let e1s7 = Episode(title: "Dragonstone", launchDate: parseToDate(string: "16/07/2017"), season: season7)
        let e2s7 = Episode(title: "Stormborn", launchDate: parseToDate(string: "23/07/2017"), season: season7)
        
        
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
    
    func seasons(filteredBy: FilterSeason) -> [Season] {
        return Repository.local.seasons.filter(filteredBy)
    }
    
}
enum HousesEnum: String {
    case Stark = "Stark"
    case Lannister = "Lannister"
    case Targaryen = "Targaryen"
}

    protocol HouseFactory {
        typealias FilterHouse = (House) -> Bool
        
        var houses: [House] { get }
        func house(named: String) -> House?
        func house(named: HousesEnum) -> House?
        func houses(filteredBy: FilterHouse) -> [House]
    }
    
    extension LocalFactory: HouseFactory {
        
        var houses: [House] {
            // Houses creation here
            let starkSigil = Sigil(image: UIImage(named: "codeIsComing.png")!, description: "Lobo Huargo")
            let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "León rampante")
            let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragón Tricéfalo")
            
            let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")! )
            let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
            let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
            
            let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
            let arya = Person(name: "Arya", house: starkHouse)
            
            let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
            let cersei = Person(name: "Cersei", house: lannisterHouse)
            let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
            
            let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
            
            // Add characters to houses
            starkHouse.add(person: arya)
            starkHouse.add(person: robb)
            lannisterHouse.add(person: tyrion)
            lannisterHouse.add(person: cersei)
            lannisterHouse.add(person: jaime)
            targaryenHouse.add(person: dani)
            
            return [starkHouse, lannisterHouse, targaryenHouse].sorted()
        }
        
        func house(named name: String) -> House? {
            let house = houses.filter{ $0.name.uppercased() == name.uppercased() }.first
            return house
        }
        
        func house(named nameEnum: HousesEnum) -> House? {
            let house = houses.filter{ $0.name == nameEnum.rawValue }.first
            return house
        }
        
        func houses(filteredBy: FilterHouse) -> [House] {
            return Repository.local.houses.filter(filteredBy)
        }
}
