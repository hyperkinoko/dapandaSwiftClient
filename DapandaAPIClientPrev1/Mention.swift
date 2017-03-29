//
//  Mention.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/01/16.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation
import ObjectMapper

class Mention: Mappable {
    var id : String?
    
    required init?(map: Map) {
    }

    init() {
        id = "dummyId"
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
    }
}
