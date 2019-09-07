//
//  User.swift
//  ChatApp
//
//  Created by Nazim Uddin on 4/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import Foundation

class User{
    let id:String?
    let name:String?
    let email:String?
    let profileImageUrl:String?
    init(dic:[String:Any],id:String) {
        self.id = id
        self.name = (dic["name"] as! String)
        self.email = (dic["email"] as! String)
        self.profileImageUrl = (dic["profileImageUrl"] as! String)
        
    }
}
