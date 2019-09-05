//
//  User.swift
//  ChatApp
//
//  Created by Nazim Uddin on 4/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import Foundation

class User{
    let name:String?
    let email:String?
    let profileImageUrl:String?
    init(name:String,email:String,profileImageUrl:String) {
        self.name = name
        self.email = email
        self.profileImageUrl = profileImageUrl
    }
}
