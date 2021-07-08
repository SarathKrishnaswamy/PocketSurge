//
//  BillsModel.swift
//  PocketSurge
//
//  Created by J.Sarath Krishnaswamy on 08/07/21.
//

import Foundation
import SwiftyJSON

struct BillsModel {
    let status : String!
    let message : String!
    let bills_data : [BillsData]?
    
    init(_ json : JSON) {
        status = json["success"].stringValue
        message = json["message"].stringValue
        bills_data = json["data"].arrayValue.map{ BillsData($0) }
    }
}
