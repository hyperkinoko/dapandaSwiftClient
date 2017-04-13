//
//  ChannelsGetResponse.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/03/29.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation
import ObjectMapper

class ChannelsGetResponse: ApiGetTelegram {
    var result: [Channel]?
    
    required init?(map: Map) {
        super.init(map: map)
        
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        result <- map["result"]
    }
}
