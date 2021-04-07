//
//  Caches.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.
//

import UIKit
class Caches: NSObject {
    
    
    static func removeAllCaches() {
        // UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.synchronize()
    }
    
    static func getCacheInt(key: String) -> Int{
        if let getCache = UserDefaults.standard.object(forKey: key) as? Int {
            return getCache
        }else{
            return 0
        }
    }
    
    static func setCacheInt(key: String, value: Int){
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    static func increaseCacheInt(key: String){
        UserDefaults.standard.setValue(getCacheInt(key: key)+1, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func setCacheDouble(key: String, value: Double){
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getCacheDouble(key: String) -> Double{
        if let getCache = UserDefaults.standard.object(forKey: key) as? Double {
            return getCache
        }else{
            return 0
        }
    }
    
    static func getCacheString(key: String) -> String{
        if let getCache = UserDefaults.standard.object(forKey: key) as? String {
            return getCache
        }else{
            return ""
        }
    }
    
    static func setCacheString(key: String, value: String){
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getCacheBool(key: String) -> Bool{
        if let getCache = UserDefaults.standard.object(forKey: key) as? Bool {
            return getCache
        }else{
            return false
        }
    }
    
    static func setCacheBool(key: String, value: Bool){
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getCacheArray(key: String) -> [String:Any]{
        if let getCache = UserDefaults.standard.object(forKey: key) as? [String:Any] {
            return getCache
        }else{
            return [:]
        }
    }
    
    static func setCacheArray(key: String, value: [String:Any] ){
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getCacheStringArray(key: String) -> [String]{
        if let getCache = UserDefaults.standard.object(forKey: key) as? [String] {
            return getCache
        }else{
            return [String]()
        }
    }
    
    static func setCacheStringArray(key: String, value: [String] ){
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
}
