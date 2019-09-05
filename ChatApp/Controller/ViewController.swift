//
//  ViewController.swift
//  ChatApp
//
//  Created by Nazim Uddin on 3/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        // User is not logged in
        let uid = "\(Auth.auth().currentUser?.uid ?? "")"
        print(uid)
        if uid.isEmpty {
            self.perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
    @objc func handleLogout(){
        do{
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginController()
        self.present(loginController, animated: true)
    }

}

