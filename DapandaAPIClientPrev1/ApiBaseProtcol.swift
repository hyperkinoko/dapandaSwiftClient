//
//  ApiBaseProtcol.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/03/07.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation

protocol ApiBaseProtcol {
//    func getGetRequestId() -> String
//    func getGetResponseId() -> String
//    func getPostRequestId() -> String
//    func getPostResponseId() -> String
//    func getPutRequestId() -> String
//    func getPutResponseId() -> String
//    func getDeleteRequestId() -> String
//    func getDeleteResponseId() -> String
//    
    func getApiName() -> String
    
    // Java版blancoRestでは throws BlancoRestException
    // というかクライアント側にこれはいらないかも
//    func execute(apiGetTelegram: ApiGetTelegram) -> ApiGetTelegram
//    func execute(apiPostTelegram: ApiPostTelegram) -> ApiPostTelegram
//    func execute(apiPutTelegram: ApiPutTelegram) -> ApiPutTelegram
//    func execute(apiDeleteTelegram: ApiDeleteTelegram) -> ApiDeleteTelegram
}
