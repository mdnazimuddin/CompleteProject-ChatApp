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
    
    var messages = [Message]()
    var messagesDic = [String:Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: String.singout, style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: String.people, style: .plain, target: self, action: #selector(hendleNewMessage))
//          let image = UIImage(named: "edit.png")
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(hendleNewMessage))
        
        // User is not logged in
    
        self.checkIfUserIsLoggedIn()
        self.observeMessages()
        tableView.register(UserCell.self, forCellReuseIdentifier: String.cell)
        
    }
    func observeMessages(){
       // let userID = Auth.auth().currentUser?.uid
        var ref = DatabaseReference.init()
        ref = Database.database().reference()
        let userRef = ref.child("messages")
        userRef.observe(.childAdded, with: { snapshot in
            if let dic = snapshot.value as? [String:Any] {
                let message = Message(dic: dic as [String : AnyObject])
              //  self.messages.append(message)
                
                if let toId = message.toId {
                    self.messagesDic[toId] = message
                    self.messages = Array(self.messagesDic.values)
                    self.messages.sort(by: { (m1, m2) -> Bool in
                        let m1 = m1.timestamp?.intValue
                        let m2 = m2.timestamp?.intValue
                        let ret = m1! > m2!
                        return  ret
                    })
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
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
                    
                    let user = User(dic: value,id: snapshot.key)
                    self.setupNavBarWithUser(user: user)
                    
                }
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
    }
    @objc func hendleNewMessage(){
        let newMessageController = NewMessagesController()
        newMessageController.messagesController = self
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
    
    func setupNavBarWithUser(user:User){
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        titleView.backgroundColor = UIColor.red
        
        //set container view
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(containerView)
        
        // need x, y, width, height anchors
        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        
        
        // set image
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        if let profileImageUrl = user.profileImageUrl {
            profileImageView.loadImageUsingCachWithUrlString(urlString: profileImageUrl)
        }
        containerView.addSubview(profileImageView)
        
        //need x, y, width, height anchors
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // set label
        let nameLabel = UILabel()
        nameLabel.text = user.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameLabel)
        
        //need x, y, width, height anchors
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        self.navigationItem.titleView = titleView
        
    }
    func showChatControllerForUser(user:User){
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewLayout())
        chatLogController.user = user
        navigationController?.pushViewController(chatLogController, animated: true)
    }

}
extension MessagesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserCell = tableView.dequeueReusableCell(withIdentifier: String.cell) as! UserCell
        let message = messages[indexPath.row]
        cell.message = message
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
