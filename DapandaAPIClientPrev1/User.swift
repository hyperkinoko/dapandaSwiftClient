//
//  File.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/01/16.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var userId: String?
    var name1: String?
    var mail: String?
    
    init(t_userId: String) {
        userId = t_userId
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        name1 <- map["name1"]
        mail <- map["mail"]
    }
    
}
