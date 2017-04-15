//
//  CommonRequest.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/03/07.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation
import ObjectMapper

class CommonRequest<T: ApiTelegram>: Mappable {
    var token: String?
    var lang: String?
    var request: ApiTelegram?
    
    init() {
        token = nil;
        lang = nil;
        request = nil;
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        lang <- map["lang"]
        request <- map["request"]
    }
}
