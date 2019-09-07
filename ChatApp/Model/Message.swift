//
//  Message.swift
//  ChatApp
//
//  Created by Nazim Uddin on 6/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit

class Message: NSObject {
    var fromId:String?
    var toId:String?
    var text:String?
    var timestamp:NSNumber?
    init(dic:[String:AnyObject])
    {
        fromId = dic["fromId"] as? String
        toId = dic["toId"] as? String
        text = dic["text"] as? String
        timestamp = dic["timestamp"] as? NSNumber
    }
}
