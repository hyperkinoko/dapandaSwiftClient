//
//  PostViewController.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2016/12/10.
//  Copyright © 2016年 kinokodata. All rights reserved.
//

import UIKit
import SwiftyJSON

class PostViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
//    var channelData : (channelId: String, name: String)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postButtonAction(_ sender: Any) {
        
        if var content = textView.text {
            // 空文字を避けたが、空白文字の連続は避けていないので後で実装すること
            // サーバ側で弾いたほうが良いかも
            while (content.hasSuffix("\n") || content.hasSuffix(" ")) {
                content = content.substring(to: content.index(content.endIndex, offsetBy: -1))
            }
            if content != "" {
                // 改行文字のエスケープ
                // 末尾の改行は、エスケープせずに取り除きたい
                content = content.replacingOccurrences(of: "\n", with: "\\n")
                print(content)
                
                let now = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let createTime = formatter.string(from: now)
                let messageId = String(arc4random())
                print(createTime)
                
                let jsonString = "{\"request\":{\"message\":{\"messageId\":\"\(messageId)\",\"channelId\":\"channelid001\",\"content\":\"\(content)\",\"createTime\":\"\(createTime)\",\"mimeType\":\"text/plain\",\"messageOwner\":{\"mail\":\"superkinoko@icloud.com\",\"name1\":\"松本キノコ\",\"userId\":\"superkinoko\"},\"mention\":null,\"editedTime\":null}},\"token\":\"dummy\",\"lang\":\"ja\"}"
                print(jsonString)
                
                // 投稿
                let url = Foundation.URL(string: "http://www.dapanda.jp:8080/dapanda/MainServlet?api=Messages")
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                request.httpBody = jsonString.data(using: String.Encoding.utf8)
                request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
                let configuration = URLSessionConfiguration.default
                let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
                let task = session.dataTask(with: request, completionHandler: {
                    (data, request, error) in
                    let json = JSON(data: data!)
                    let status = json["status"].stringValue
                    print(status)                    
                    if status == "SUCCESS" {
                        _ = self.navigationController?.popViewController(animated: true)
                    } else {
                        print("投稿に失敗しました")
                        let alertController = UIAlertController(title: "失敗", message: "投稿に失敗しました", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
//                        self.textView.text.removeAll()
                    }
                })
                task.resume()
//                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
