//
//  BillsData.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 08/07/21.
//

import Foundation
import SwiftyJSON

struct BillsData {
    let id : String!
    let category_id : String!
    let amount : String!
    let user_id : String!
    let title : String!
    let date : String!
    
    
    init(_ json : JSON) {
        id = json["id"].stringValue
        category_id = json["category_id"].stringValue
        amount = json["amount"].stringValue
        user_id = json["user_id"].stringValue
        title = json["title"].stringValue
        date = json["date"].stringValue
    }
}
