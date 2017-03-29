//
//  SelectChannnelViewController.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2016/12/10.
//  Copyright © 2016年 kinokodata. All rights reserved.
//

import UIKit
import SwiftyJSON

class SelectChannnelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var channelList : [(channelId: String, name: String)] = []
    var channelData : (channelId: String, name: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reloadCannel(memberId: "superkinoko")
        
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadCannel(memberId: String) {
        let url = Foundation.URL(string: "http://www.dapanda.jp:8080/dapanda/MainServlet?api=Channels&token=dummy&lang=ja&memberId=\(memberId)")
        print(url!)
        
        let request = URLRequest(url: url!)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, request, Error) in
            
            let json = JSON(data: data!)
            let channels: Array<JSON> = json["response"]["result"].arrayValue
            print(channels.count)
            
            for channel in channels {
                let id = channel["channelId"].stringValue
                let name = channel["name"].stringValue
                
                let channelTuple = (id, name)
                self.channelList.append(channelTuple)
                print("data = \(channelTuple)")
            }
            
            self.tableView.reloadData()
        })
        task.resume()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath)
        
        cell.textLabel?.text = channelList[indexPath.row].name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        channelData = (channelList[indexPath.row].channelId, channelList[indexPath.row].name)
        self.performSegue(withIdentifier: "goMessageList", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! ViewController
        nextViewController.channelData = self.channelData
    }
    
    /*func getMassage(for channelID: String) -> [Message]? {
        
    }*/
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
