//
//  Messages.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/03/06.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation
import ObjectMapper


// Java版では手書きだが、クライアント側の場合、ここを自動生成するべきか
//class Messages: ApiBase, ApiBaseProtcol {
class Messages {
    func getApiName() -> String {
        return "Messages"
    }
    
    func send(request: MessagesGetRequest) -> MessagesGetResponse {
        super.sendTo(request: request, httpMethod: String)
    }

    func send(request: MessagesPutRequest) -> MessagesPutResponse {
        super.sendTo(request: request, httpMethod: String)
        
    }

    func send(request: MessagesPostRequest) -> MessagesPostResponse {
        super.sendTo(request: ApiPostTelegram, httpMethod: String)
        
    }

    func send(request: MessagesDeleteRequest) -> MessagesDeleteResponse {
        super.sendTo(request: ApiDeleteTelegram, httpMethod: String)
        
    }

}
