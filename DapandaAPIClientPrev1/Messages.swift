//
//  Messages.swift
//  DapandaAPIClientPrev1
//
//  Created by superkinoko on 2017/03/06.
//  Copyright © 2017年 kinokodata. All rights reserved.
//

import Foundation


// Java版では手書きだが、クライアント側の場合、ここを自動生成するべきか
class Messages: ApiBase, ApiBaseProtcol {
    func getApiName() -> String {
        return "Messages"
    }
}
