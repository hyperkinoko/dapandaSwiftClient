//
//  MessagesPutResponse.swift
//  DapandaAPIClientPrev1
//
//  Created by Nao Akakura on 2017/04/15.
//  Copyright © 2017 kinokodata. All rights reserved.
//

import Foundation
import ObjectMapper

// フィールドとイニシャライザ、ObjectMapperのためのメソッドを持つ
// blancoValueObjectによって自動生成されなくてはならない (本コードは手動生成)
class MessagesPutResponse: ApiPutTelegram {
    var result: String?
    
    required init?(map: Map) {
        super.init(map: map)
        
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        result <- map["result"]
    }
}