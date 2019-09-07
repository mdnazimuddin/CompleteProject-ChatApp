//
//  LoginController+handler.swift
//  ChatApp
//
//  Created by Nazim Uddin on 4/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

extension LoginController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @objc func handleSelectProfileImageView(){
        if loginRegisterSegmentControl.selectedSegmentIndex == 1 {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }else{
            return
        }
       
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        profileImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LoginController{
    
    
    
    @objc func hendleLoinRegister(){
        if loginRegisterSegmentControl.selectedSegmentIndex == 0 {
            self.hendleLogin()
        }else{
            self.hendleRegister()
        }
    }
    func hendleLogin(){
        guard let email = emailTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if error != nil {
                print("Error: \(error?.localizedDescription ?? "")")
                return
            }
            //Auth Logged In Successfull
            self.dismiss(animated: true, completion: nil)
        }
    }
    func hendleRegister(){
        guard let name = nameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error != nil  {
                print("Error: \(error?.localizedDescription ?? "")")
                return
            }
            // Authenticated Successful User Creat
            let uid = user?.user.uid
            
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
//            let uploadImage = self.profileImageView.image?.pngData()
            let uploadImage = self.profileImageView.image?.jpegData(compressionQuality: 0.1)
            
            storageRef.putData(uploadImage!, metadata: nil) { (metadata, error) in
                if error == nil {
                    storageRef.downloadURL(completion: { (url, error) in
                        guard let url = url?.absoluteString else {return}
                        let userDic = ["name":name,"email":email,"profileImageUrl":url] as [String : Any]
                        self.registerUserIntoDatabasewithUID(uid: uid!,userDic: userDic)
                    })
                }else{
                    print("error save image")
                }
            }
            
        }
        
    }
    private func registerUserIntoDatabasewithUID(uid:String,userDic:[String:Any]){
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child(uid).setValue(userDic)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hendleLoginRegisterChange(){
        let title = loginRegisterSegmentControl.titleForSegment(at: loginRegisterSegmentControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        //change height of inputContainerView
        
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 100 : 150
        
        //change height of nameTextField
        
        
        if loginRegisterSegmentControl.selectedSegmentIndex == 0 {
            nameTextFieldHeightAnchor?.isActive = false
            
            nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
            nameTextFieldHeightAnchor?.isActive = true
            
            emailTextFieldHeightAnchor?.isActive = false
            emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            emailTextFieldHeightAnchor?.isActive = true
            
            passTextFieldHeightAnchor?.isActive = false
            passTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            passTextFieldHeightAnchor?.isActive = true
            
            profileImageView.image = UIImage(named: String.chatImageName)
        }else{
            nameTextFieldHeightAnchor?.isActive = false
            
            nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
            nameTextFieldHeightAnchor?.isActive = true
            
            emailTextFieldHeightAnchor?.isActive = false
            emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
            emailTextFieldHeightAnchor?.isActive = true
            
            passTextFieldHeightAnchor?.isActive = false
            passTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
            passTextFieldHeightAnchor?.isActive = true
            
            profileImageView.image = UIImage(named: String.defaultImageName)
        }
        
        
    }
}
