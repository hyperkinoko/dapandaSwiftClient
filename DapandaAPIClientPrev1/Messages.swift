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
        var response: MessagesGetResponse = MessagesGetResponse()
        let commonRequest: CommonRequest = CommonRequest()
        let semaphore = DispatchSemaphore(value: 0)
        
        commonRequest.lang = "ja"
        commonRequest.token = "dummy"
        commonRequest.request = request
        
        // requestからURLに乗せるデータを作る
        var urlString = "http://www.dapanda.jp:8080/dapanda/MainServlet?api="
        urlString += self.getApiName()
        urlString += "&token="
        urlString += commonRequest.token!
        urlString += "&lang="
        urlString += commonRequest.lang!
        
        // ここから、property一覧を得て、中身がnilでなければurlにデータをくっつけていく
        let mirror = Mirror(reflecting: request)
        for element in mirror.children {
            if let value = element.value as? String {
                urlString += "&\(element.label!)="
                urlString += value
            }
        }
        // こっちのほうが書き方としてはエレガント
        /*mirror.children.forEach {
            if let value = $0.value as? String {
                urlString += “&\($0.label!)="
                urlString += value
            }
        }*/
        
        print(urlString)
        let url = URL(string: urlString)
        
        let urlRequest = URLRequest(url: url!)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, request, error) in
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                print(json)
                
                // MessageGetResponseの部分はreflectionを使う
                let commonResponse: CommonResponse = Mapper<CommonResponse<MessagesGetResponse>>().map(JSON: json)!
                response = commonResponse.response!
                    print(response)
            } catch {
                print("ERROR!! json parse error")
            }
            semaphore.signal()
            
        })
        task.resume()

        semaphore.wait()
        return response
    }
}
