//
//  CommonResponse.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/03/07.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation
import ObjectMapper

class CommonResponse: Mappable {
    
    var token: String?
    var response: ApiTelegram?
    var lang: String?
    var status: String?
    var code: Int?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        response <- map["response"]
        lang <- map["lang"]
        status <- map["status"]
        code <- map["code"]
        message <- map["message"]
    }
    
}
