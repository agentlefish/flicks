//
//  AppDelegate.swift
//  Flicks
//
//  Created by Xiang Yu on 9/14/17.
//  Copyright © 2017 Xiang Yu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nowPlayingNavController = storyboard.instantiateViewController(withIdentifier: "MoviesNavController") as! UINavigationController
        let nowPlayingViewController = nowPlayingNavController.topViewController as! MainListViewController
        nowPlayingViewController.endpoint = "now_playing"
        nowPlayingViewController.tabBarItem.title = "Now Playing"
        nowPlayingViewController.tabBarItem.image = UIImage(named: "now_playing_50")?.withRenderingMode(.alwaysOriginal)
        
        let topRatedNavController = storyboard.instantiateViewController(withIdentifier: "MoviesNavController") as! UINavigationController
        let topRatedViewController = topRatedNavController.topViewController as! MainListViewController
        topRatedViewController.endpoint = "top_rated"
        topRatedNavController.tabBarItem.title = "Top Rated"
        topRatedNavController.tabBarItem.image = UIImage(named: "top_rated_50")?.withRenderingMode(.alwaysOriginal)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nowPlayingNavController, topRatedNavController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
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

