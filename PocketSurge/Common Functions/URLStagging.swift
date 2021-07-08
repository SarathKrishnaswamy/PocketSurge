//
//  URLStagging.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 07/07/21.
//

import Foundation
import UIKit

enum Environment: String {
    case Production   = "https://pocketsurge.venkeywonder.com"
    case Testing     = "https://"
    case Development  = ""
}

enum Route: String {
  case api  = "/"
}

extension URL {
    
    // MARK:- register api
    static var register: String {
        let domain = "\(UserDefaults.standard.object(forKey: Key.UserDefaults.stagingURL) ?? "")"
        let api = domain + Route.api.rawValue
        return api + "reg.php"
    }
    
    // MARK:- login api
    static var login: String {
        let domain = "\(UserDefaults.standard.object(forKey: Key.UserDefaults.stagingURL) ?? "")"
        let api = domain + Route.api.rawValue
        return api + "login.php"
    }
    
    // MARK:- add_entry api
    static var add_entry: String {
        let domain = "\(UserDefaults.standard.object(forKey: Key.UserDefaults.stagingURL) ?? "")"
        let api = domain + Route.api.rawValue
        return api + "add_entry.php"
    }
    
    // MARK:- all_categories api
    static var all_categories: String {
        let domain = "\(UserDefaults.standard.object(forKey: Key.UserDefaults.stagingURL) ?? "")"
        let api = domain + Route.api.rawValue
        return api + "all_categories.php"
    }
    
    // MARK:- all_entries api
    static var all_entries: String {
        let domain = "\(UserDefaults.standard.object(forKey: Key.UserDefaults.stagingURL) ?? "")"
        let api = domain + Route.api.rawValue
        return api + "all_entries.php"
    }
    
    // MARK:- delete_entry api
    static var delete_entry: String {
        let domain = "\(UserDefaults.standard.object(forKey: Key.UserDefaults.stagingURL) ?? "")"
        let api = domain + Route.api.rawValue
        return api + "delete_entry.php"
    }
    
    
    
}
