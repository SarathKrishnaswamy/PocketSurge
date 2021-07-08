//
//  CategoryModel.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 07/07/21.
//

import Foundation
import SwiftyJSON

struct CategoryModel {
    let status : String!
    let message : String!
    let Category_Data : [CategoryData]?
    
    init(_ json : JSON) {
        status = json["success"].stringValue
        message = json["message"].stringValue
        Category_Data = json["data"].arrayValue.map{ CategoryData($0) }
    }
}
