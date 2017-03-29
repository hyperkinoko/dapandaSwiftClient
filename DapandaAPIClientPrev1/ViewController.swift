//
//  ViewController.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2016/12/09.
//  Copyright © 2016年 kinokodata. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var messageList = Array<Message>()
    var channelData : (channelId: String, name: String)?
    var messageData : (messageId: String, content: String)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = channelData?.name
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
//        reloadMessages(channelId: (channelData?.channelId)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadMessages(channelId: String) {
        messageList.removeAll()
        
        let url = URL(string: "http://www.dapanda.jp:8080/dapanda/MainServlet?api=Messages&token=dummy&lang=ja&channelId=\(channelId)")
        print(url!)
        
        let request = URLRequest(url: url!)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, request, error) in
            
            let json = JSON(data: data!)
            let messagesJson: String = json.rawString()!
//            print(messagesJson)
            
            let commonResponse: CommonResponse = Mapper<CommonResponse>().map(JSONString: messagesJson)!
            print(commonResponse)
            //self.messageList = Mapper<Message>().mapArray(JSONString: messagesJson)!
            let response = commonResponse.response as! MessagesGetResponse
            self.messageList = response.result!
            self.tableView.reloadData()
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! CustomTableViewCell
        
        cell.ownerLabel?.text = messageList[indexPath.row].messageOwner?.name1
        cell.contentTextView?.text = messageList[indexPath.row].content
        cell.createTimeLabel?.text = messageList[indexPath.row].createTime
        
        return cell
    }
    
    @IBAction func postButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "goPostView", sender: nil)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        reloadMessages(channelId: (channelData?.channelId)!)
    }

    @IBAction func editButtonAction(_ sender: Any) {
        // 押されたボタンを取得
        let botton = sender as! UIButton
        let cell = botton.superview?.superview as! CustomTableViewCell
        
        // クリックされたcellの位置を取得
        if let row = tableView.indexPath(for: cell)?.row {
            print(row)
            messageData = (messageList[row].messageId!, messageList[row].content!)
            print(messageData!)
            self.performSegue(withIdentifier: "goEditMessage", sender: nil)
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        // 押されたボタンを取得
        let botton = sender as! UIButton
        let cell = botton.superview?.superview as! CustomTableViewCell
        
        // クリックされたcellの位置を取得
        guard let row = tableView.indexPath(for: cell)?.row else {
            return
        }
        print(row)
        
        let alertController = UIAlertController(title: "削除", message: "本当に削除しますか？", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "削除", style: .destructive, handler: {action in
            print("削除ボタンが押された at row: \(row)")
            
            // DELETEリクエスト発行
            let messageId = self.messageList[row].messageId
            let url = URL(string: "http://10.211.55.3:8080/dapanda/MainServlet?api=Messages&token=dummy&lang=ja&messageId=\(messageId)")
            print(url!)
            
            var request = URLRequest(url: url!)
            request.httpMethod = "DELETE"
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request, completionHandler: {
                (data, request, error) in
                let json = JSON(data: data!)
                let status = json["status"].stringValue
                print(status)
                if status == "SUCCESS" {
                    print("削除しました")
                    self.reloadMessages(channelId: (self.channelData?.channelId)!)
                } else {
                    print("削除に失敗しました")
                    let alertController = UIAlertController(title: "失敗", message: "削除に失敗しました", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    //                        self.textView.text.removeAll()
                }
            })
            task.resume()

            
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEditMessage" {
            let nextViewController = segue.destination as! EditViewController
            nextViewController.messageData = self.messageData
        }
    }
    
    func getMessages(channelId: String) -> [Message]? {
        var messages: [Message]?
        let messagesApi: Messages = Messages()
        let request: MessagesGetRequest = MessagesGetRequest()
        request.channelId = channelId
        request.limit = "4"
        
        // この処理をしてから
        messagesApi.send(request: request, resultHandler: {(respons: ApiGetTelegram?, error: Error?) -> () in
            if let res = respons as! MessagesGetResponse? {
                messages = res.result
            } else {
                messages = nil
            }
            if let _ = error {
                print(error!)
                messages = nil
            }
        })
        
        // この処理をする
        return messages
    }
    
}

