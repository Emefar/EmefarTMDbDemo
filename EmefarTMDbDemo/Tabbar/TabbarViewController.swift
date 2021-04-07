//
//  TabbarViewController.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.
//  Copyright © 2021 Emefar. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        
        prepareVCs()
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
