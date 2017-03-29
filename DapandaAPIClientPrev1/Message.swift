//
//  Message.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/01/15.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation
import ObjectMapper

class Message: Mappable {
    var messageId: String?
    var messageOwner: User?
    var createTime: String?
    var content: String?
    var mimeType: String?
    var mention: Mention?
    var channelId: String?
    var editedTime: String?
    
    required init?(map: Map) {
        
    }
    
    func  mapping(map: Map) {
        messageId <- map["messageId"]
        messageOwner <- map["messageOwner"]
        createTime <- map["createTime"]
        content <- map["content"]
        mimeType <- map["mimeType"]
        mention <- map["mention"]
        channelId <- map["channelId"]
        editedTime <- map["editedTime"]
    }
    
    init(t_owner: String, t_content: String, t_channelId: String) {
        messageId = "dummymessageId"
        messageOwner = User(t_userId: "superkinoko")
        createTime = "2017-01-05 13:38:48"
        content = "dummy"
        mimeType = "text/plain"
        channelId = "channelid001"
    }
    
    init(t_messageId: String, t_owner: String, t_createTime: String, t_content: String, t_mimeType: String, t_channelId: String, t_editedTime: String) {
        messageId = t_messageId
        messageOwner = User(t_userId: t_owner)
        createTime = t_createTime
        content = t_content
        mimeType = t_mimeType
        channelId = t_channelId
        editedTime = t_editedTime
    }
}
