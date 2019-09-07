//
//  ChatLogController.swift
//  ChatApp
//
//  Created by Nazim Uddin on 6/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatLogController: UICollectionViewController,UITextFieldDelegate {

    var user:User?
    lazy var inputTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = user?.name
        collectionView.backgroundColor = UIColor.white
        self.setupInputComponents()
    }
    func setupInputComponents(){
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        //need x,y,width,height anchors
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // add button
        let buttonView = UIButton(type: .system)
        buttonView.setTitle(String.send, for: .normal)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        containerView.addSubview(buttonView)
        
        //need x, y,width, heigth anchors
        buttonView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 2).isActive = true
        buttonView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        buttonView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        buttonView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        // add textField
       
        containerView.addSubview(inputTextField)
        
        //need x, y, width, height anchors
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor,constant: 8).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: buttonView.leftAnchor).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        // add separator line view
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLineView)
        
        //need x, y, width, heigth anchors
        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        separatorLineView.bottomAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    @objc func handleSendMessage(){
        let toId = user!.id
        let fromId = Auth.auth().currentUser?.uid
        let timestamp:NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        let messDic = ["text":inputTextField.text!,"toId":toId!,"fromId":fromId!,"timestamp":timestamp] as [String : Any]
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("messages").childByAutoId().setValue(messDic)
        inputTextField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSendMessage()
        return true
    }

}
