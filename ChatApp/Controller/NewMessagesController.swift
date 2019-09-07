//
//  NewMessagesController.swift
//  ChatApp
//
//  Created by Nazim Uddin on 4/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class NewMessagesController: UITableViewController {

    var ref = DatabaseReference.init()
    var users = [User]()
    var messagesController:MessagesController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: String.cancel, style: .plain, target: self, action: #selector(hendleCancel))
        self.tableView.register(UserCell.self, forCellReuseIdentifier: String.cell)
        self.fetchUser()
    }
    func fetchUser(){
        
        ref = Database.database().reference()
        let userRef = ref.child("users")
        userRef.observe(.childAdded, with: { snapshot in
            if let dic = snapshot.value as? [String:Any] {
                let user = User(dic:dic,id: snapshot.key)
                self.users.append(user)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            //print(snapshot)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    @objc func hendleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserCell = tableView.dequeueReusableCell(withIdentifier: String.cell, for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        cell.profileImageView.contentMode = .scaleAspectFill
        
        if let profileImageUrl = user.profileImageUrl {
            cell.profileImageView.loadImageUsingCachWithUrlString(urlString: profileImageUrl)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            let user = self.users[indexPath.row]
            
            self.messagesController?.showChatControllerForUser(user: user)
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
