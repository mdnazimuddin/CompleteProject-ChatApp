//
//  ViewController.swift
//  ChatApp
//
//  Created by Nazim Uddin on 3/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    @objc func handleLogout(){
        let loginController = LoginController()
        self.present(loginController, animated: true)
    }

}

