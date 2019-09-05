//
//  MessagesController.swift
//  ChatApp
//
//  Created by Nazim Uddin on 4/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MessagesController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Message", style: .plain, target: self, action: #selector(hendleNewMessage))
         // let image = UIImage(named: "edit.png")
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(hendleNewMessage))
        
        // User is not logged in
    
        self.checkIfUserIsLoggedIn()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.checkIfUserIsLoggedIn()
    }
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser?.uid == nil {
            self.perform(#selector(self.handleLogout), with: nil, afterDelay: 0)
        }else{
            
            let userID = Auth.auth().currentUser?.uid
            var ref = DatabaseReference.init()
            ref = Database.database().reference()
            let userRef = ref.child("users").child(userID!)
            userRef.observe(.value, with: { snapshot in
                if let value = snapshot.value as? [String:Any] {
                  self.navigationItem.title = value["name"] as? String
                }
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
    }
    @objc func hendleNewMessage(){
        let newMessageController = NewMessagesController()
        let navController = UINavigationController(rootViewController: newMessageController)
        self.present(navController, animated: true)
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
