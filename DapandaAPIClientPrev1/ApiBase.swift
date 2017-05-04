//
//  ApiBase.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/03/06.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

// これは手書き

class ApiBase {

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    let delegate: ApiBaseProtcol? = nil
    
    func getApiName() -> String {
        return "";
    }
    
    init() {
        delegate = nil
    }
    
    func sendTo(request: MessagesGetRequest) -> MessagesGetResponse {
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
        mirror.children.forEach {
         if let value = $0.value as? String {
         urlString += "&\($0.label!)="
         urlString += value
         }
        }
        
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

    
    final func sendTo(request: ApiTelegram, method: HTTPMethod, resultHandler: @escaping (ApiTelegram, Error?) -> ()) {
        //var response: ApiTelegram
        
        let commonRequest: CommonRequest = CommonRequest()
        commonRequest.token = "dummy"
        commonRequest.lang = "ja"
        commonRequest.request = request

        // まずURLのStringを作る
        let apiName = delegate?.getApiName()
        var urlString = "http://www.dapanda.jp:8080/dapanda/MainServlet?api=\(apiName ?? "")"

        switch method {
        case .get, .delete:
            // GETとDELETEはURLにデータを乗せる
            print("This is GET or Delete method.")
            urlString += "&token=" + commonRequest.token!
            urlString += "&lang=" + commonRequest.lang!
            
            // ここでURLにデータを乗せる
            
            urlString += "&channelId=channelid001"
            
            print(urlString)
        case .post, .put:
            // POSTとPUTはJSONにデータを乗せる
            print("This is GET method.")
            print(urlString)
        }
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, request, error) in
            
            let json = JSON(data: data!)
            let messagesJson: String = json.rawString()!
            //            print(messagesJson)
            
            let commonResponse: CommonResponse = Mapper<CommonResponse<ApiTelegram>>().map(JSONString: messagesJson)!
            resultHandler(commonResponse.response!, nil)
            print()
        })
        task.resume()
    }
    
    final func send(request: ApiGetTelegram, resultHandler: @escaping (ApiGetTelegram, Error?) -> ()) {
//        _: ApiTelegram = ApiTelegram()
        
//        let group = DispatchGroup()
        
//        group.enter()
//        DispatchQueue.global().async {
            self.sendTo(request: request, method: HTTPMethod.get, resultHandler: {(response: ApiTelegram, error: Error?) -> () in
                resultHandler(response as! ApiGetTelegram, nil)
//                group.leave()
            })
//        }
    }
    
    /*final func send(request: ApiPostTelegram) -> ApiPostTelegram {
        var responsData: ApiTelegram
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            self.sendTo(request: request, method: HTTPMethod.get, response: {(response: ApiTelegram) -> () in
                responsData = response
                group.leave()
            })
        }
        // 上のタスクが終了してから実行する
        group.notify(queue: DispatchQueue.main) {
            return responsData as! ApiGetTelegram
        }
    }
    
    final func send(request: ApiPutTelegram) -> ApiPutTelegram {
        var responsData: ApiTelegram
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            self.sendTo(request: request, method: HTTPMethod.get, response: {(response: ApiTelegram) -> () in
                responsData = response
                group.leave()
            })
        }
        // 上のタスクが終了してから実行する
        group.notify(queue: DispatchQueue.main) {
            return responsData as! ApiGetTelegram
        }
    }
    
    final func send(request: ApiDeleteTelegram) -> ApiDeleteTelegram {
        var responsData: ApiTelegram
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            self.sendTo(request: request, method: HTTPMethod.get, response: {(response: ApiTelegram) -> () in
                responsData = response
                group.leave()
            })
        }
        // 上のタスクが終了してから実行する
        group.notify(queue: DispatchQueue.main) {
            return responsData as! ApiGetTelegram
        }
    }*/
    
    // 本来はBlancoRestExceptionエラーを投げる
    /*final func getOutputInstance(method: HTTPMethod) -> ApiTelegram {
        var response: ApiTelegram?
        var responseId: String?
        
        switch method {
        case .get:
            responseId = delegate?.getGetResponseId()
        case .post:
            responseId = delegate?.getPostResponseId()
       case .put:
            responseId = delegate?.getPutResponseId()
        case .delete:
            responseId = delegate?.getDeleteResponseId()
        }
        
        
        let clazz = NSClassFromString(responseId!)
        
//        Constructor<?> constructor =
//        clazz.getConstructor(new Class<?>[0]);
        
        // インスタンス生成
//        response = (ApiTelegram) constructor.newInstance();
//        } catch (ClassNotFoundException e) {
//        e.printStackTrace();
//        } catch (InvocationTargetException e) {
//        e.printStackTrace();
//        } catch (NoSuchMethodException e) {
//        e.printStackTrace();
//        } catch (InstantiationException e) {
//        e.printStackTrace();
//        } catch (IllegalAccessException e) {
//        e.printStackTrace();
//        }
        
//        return response;
    }*/
}
