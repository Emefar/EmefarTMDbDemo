//
//  TabbarViewController.swift
//  EmefarTMDbDemo
//
//  Created by Mervan Şahinkaya on 15.03.2022.
//  Copyright © 2022 Mervan Şahinkaya. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        
        prepareVCs()
        
        if #available(iOS 15, *) {
           let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .white
       
           tabBar.standardAppearance = tabBarAppearance
           tabBar.scrollEdgeAppearance = tabBarAppearance
        } else {
           
            tabBar.barTintColor = .white
         }
        
    }
    
    
    func prepareVCs(){
        
        viewControllers = [
            createNavController(for: MovieViewController(), title: "Search", image: #imageLiteral(resourceName: "film")),
            createNavController(for: WatchlistViewController(), title: "Watchlist", image: #imageLiteral(resourceName: "list")),
            createNavController(for: FavoritesViewController(), title: "Favorites", image: #imageLiteral(resourceName: "heart"))
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }
    
    
}
