//
//  MessagesGetResponse.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/03/06.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation
import ObjectMapper

class MessagesGetResponse: ApiGetTelegram {
    var result: [Message]?
    
    required init?(map: Map) {
        super.init(map: map)
        
    }
    
    override init() {
        result = nil
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        result <- map["result"]
    }
}
