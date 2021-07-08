//
//  CategoryData.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 07/07/21.
//

import Foundation
import SwiftyJSON

struct CategoryData {
    let id : String!
    let category : String!
    
    init(_ json : JSON) {
        id = json["id"].stringValue
        category = json["category"].stringValue
    }
}
