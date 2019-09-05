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
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(hendleCancel))
        self.tableView.register(UserCell.self, forCellReuseIdentifier: "cell")
        self.fetchUser()
    }
    func fetchUser(){
        
        ref = Database.database().reference()
        let userRef = ref.child("users")
        userRef.observe(.childAdded, with: { snapshot in
            if let dic = snapshot.value as? [String:Any] {
                let user = User(name: dic["name"] as! String, email: dic["email"] as! String, profileImageUrl: dic["profileImageUrl"] as! String)
               // print(user.name!)
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
        let cell:UserCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserCell
        cell.textLabel?.text = users[indexPath.row].name
        cell.detailTextLabel?.text = users[indexPath.row].email
        return cell
    }
}
