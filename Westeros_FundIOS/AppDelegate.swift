//
//  AppDelegate.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 03/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var seasonDetailViewController: SeasonDetailViewController!
    var houseDetailViewController: HouseDetailViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // Crear los modelos
        let seasons = Repository.local.seasons
        let houses = Repository.local.houses
        
        // Creamos los controladores masterViewController
        let seasonListViewController = SeasonListViewController(model: seasons)
        let houseListViewController = HouseListViewController(model: houses)
        
        // Persistencia 
        // let lastSelectedSeason = seasonListViewController.lastSelectedSeason()
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        
        // Creamos los controladores detailViewController
        seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        
        // Asignar delegados
        seasonListViewController.delegate = seasonDetailViewController
        seasonListViewController.title = "Seasons"
        houseListViewController.delegate = houseDetailViewController
        houseListViewController.title = "Houses"
        
        // Unir masters (SeasonList y HouseList) en UITabBar + navigation
        let tabBarController = UITabBarController()
        tabBarController.delegate = self
        tabBarController.viewControllers = [seasonListViewController.wrappedInNavigation(), houseListViewController.wrappedInNavigation()]
        
        // Crear el UISplitVC y le asignamos los viewControllers (master y detail)
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
            tabBarController, seasonDetailViewController.wrappedInNavigation()
        ]
        
        // Asignamos el rootVC
        window?.rootViewController = splitViewController
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let viewController = viewController.childViewControllers[0]
        var detailViewController = UIViewController()
        if(viewController is SeasonListViewController){
            detailViewController = seasonDetailViewController
        }
        else if(viewController is HouseListViewController){
            detailViewController = houseDetailViewController
        }
        
        viewController.showDetailViewController(detailViewController.wrappedInNavigation(), sender:self )
    }
    
}
