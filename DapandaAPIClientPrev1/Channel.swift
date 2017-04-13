//
//  Channel.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/03/29.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation
import ObjectMapper

class Channel : Mappable {
    var channelId: String?
    var name: String?
    var members: [User]?
    var administrators: [User]?
    var isPublic: Bool?
    
    required init?(map:Map) {
    
    }
    
    func mapping(map: Map) {
        channelId <- map["channelId"]
        name <- map["name"]
        members <- map["members"]
        administrators <- map["administrators"]
        isPublic <- map["isPublic"]
    }
}
