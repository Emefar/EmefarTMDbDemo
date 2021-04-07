//
//  SceneDelegate.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.
//  Copyright © 2021 Emefar. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        

        if !Caches.getCacheBool(key: "isUserLoggedIn"){
            self.window?.rootViewController = LoginViewController()
        }else{
            self.window?.rootViewController = TabbarViewController()
        }
        
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print("sceneDidDisconnect")
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("sceneDidBecomeActive")
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        print("sceneWillResignActive")
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("sceneWillEnterForeground")
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("sceneDidEnterBackground")
    }
    
    
}

