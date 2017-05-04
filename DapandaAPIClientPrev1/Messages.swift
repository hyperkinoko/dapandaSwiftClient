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
/*
    override func getApiName() -> String {
        return "Messages"
    }
 */
    var apiBase: ApiBase = ApiBase()
    
    func send(request: MessagesGetRequest) -> MessagesGetResponse {
        let telegram: ApiTelegram = request
        //super.sendTo(request: telegram, httpMethod: HTTPMethod.get)
        apiBase.sendTo(request: telegram, httpMethod: ApiBase.HTTPMethod.get)
    }

    func send(request: MessagesPutRequest) -> MessagesPutResponse {
        //super.sendTo(request: request, httpMethod: HTTPMethod.put)
        apiBase.sendTo(request: request, httpMethod: ApiBase.HTTPMethod.put)
    }

    func send(request: MessagesPostRequest) -> MessagesPostResponse {
        //super.sendTo(request: ApiPostTelegram, httpMethod: ApiBase.HTTPMethod.post)
        apiBase.sendTo(request: ApiPostTelegram, httpMethod: ApiBase.HTTPMethod.post)
        
    }

    func send(request: MessagesDeleteRequest) -> MessagesDeleteResponse {
        //super.sendTo(request: ApiDeleteTelegram, httpMethod: ApiBase.HTTPMethod.delete)
        apiBase.sendTo(request: ApiDeleteTelegram, httpMethod: ApiaBase.HTTPMethod.delete)
    }

}
