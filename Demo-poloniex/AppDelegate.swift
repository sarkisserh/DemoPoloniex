//
//  AppDelegate.swift
//  Demo-poloniex
//
//  Created by macbook on 23.07.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let tickerListVC = TickerListVC()
        let nc = UINavigationController(rootViewController: tickerListVC)
        window?.rootViewController = nc
        
        return true
    }

}
