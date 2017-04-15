//
//  MessagesGetTelegram.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/03/06.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation
import ObjectMapper

// フィールドとイニシャライザ、ObjectMapperのためのメソッドを持つ
// 自動生成される
class MessagesGetRequest: ApiGetTelegram {
    
    var messageId: String?
    var userId: String?
    var postedDateFrom: String?
    var postedDateTo: String?
    var channelId: String?
    var limit: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override init() {
        messageId = nil
        userId = nil
        postedDateFrom = nil
        postedDateTo = nil
        channelId = nil
        limit = nil
        super.init()
    }
        
    override func mapping(map: Map) {
        super.mapping(map: map)
        messageId <- map["messageId"]
        userId <- map["userId"]
        postedDateFrom <- map["postedDateFrom"]
        postedDateTo <- map["postedDateTo"]
        channelId <- map["channelId"]
        limit <- map["limit"]
    }
}
