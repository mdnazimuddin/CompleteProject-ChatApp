//
//  UserCell.swift
//  ChatApp
//
//  Created by Nazim Uddin on 4/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
