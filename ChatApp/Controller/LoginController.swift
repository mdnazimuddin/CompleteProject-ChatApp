//
//  LoginController.swift
//  ChatApp
//
//  Created by Nazim Uddin on 3/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController {
    
    // UI Design
    let profileImageView = UIImageView()
    let inputsContainerView = UIView()
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginRegisterButton = UIButton(type: .system)
    var loginRegisterSegmentControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
       
        self.setupInputContainerView()
        self.setupLoginRegisterButton()
        self.setupProfileImageView()
        self.setupLoginRegisterSegmentedControl()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func setupProfileImageView(){
        profileImageView.image = UIImage(named: "profile.png")
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        view.addSubview(profileImageView)
        
        //need x, y, width, height constraints
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    func setupInputContainerView(){
        
        inputsContainerView.backgroundColor = UIColor.white
        inputsContainerView.translatesAutoresizingMaskIntoConstraints = false
        inputsContainerView.layer.cornerRadius = 5
        inputsContainerView.layer.masksToBounds = true
        view.addSubview(inputsContainerView)
        
        //need x, y, width, height constraints
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        
        // setup sub inputsContainerView
        setupNameTextField()
        setupSeparatorView(bottomAnchor: nameTextField.bottomAnchor)
        setupEmailTextField()
        setupSeparatorView(bottomAnchor: emailTextField.bottomAnchor)
        setupPasswordTextField()
    }
    func setupNameTextField(){
        nameTextField.placeholder = "Name"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        inputsContainerView.addSubview(nameTextField)
        
        //need x, y, width, height constraints
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
    }
    func setupEmailTextField(){
        emailTextField.placeholder = "Email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        inputsContainerView.addSubview(emailTextField)
        
        //need x, y, width, height constraints
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
    }
    func setupPasswordTextField(){
        passwordTextField.placeholder = "Password"
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        //passwordTextField.isSecureTextEntry = true
        inputsContainerView.addSubview(passwordTextField)
        
        //need x, y, width, height constraints
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
    }
    func setupSeparatorView(bottomAnchor:NSLayoutYAxisAnchor){
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        inputsContainerView.addSubview(separatorView)
        
        //need x, y, width, height constraints
        separatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    func setupLoginRegisterButton(){
        
        loginRegisterButton.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        loginRegisterButton.setTitle("Register", for: .normal)
        loginRegisterButton.setTitleColor(UIColor.white, for: .normal)
        loginRegisterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginRegisterButton.translatesAutoresizingMaskIntoConstraints = false
        loginRegisterButton.addTarget(self, action: #selector(hendleRegister), for: .touchUpInside)
        view.addSubview(loginRegisterButton)
        
        //need x, y, width, height constraints
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupLoginRegisterSegmentedControl(){
        let items = ["Login","Register"]
        loginRegisterSegmentControl = UISegmentedControl(items: items)
        loginRegisterSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginRegisterSegmentControl)
        
         //need x, y, width, height constraints
    }
    
}

extension LoginController{
    @objc func hendleRegister(){
        guard let name = nameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error != nil  {
               print("Error: \(error?.localizedDescription)")
                return
            }
            // Authenticated Successful create
            let userDic = ["name":name,"email":email]
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("user").childByAutoId().setValue(userDic)
            print("Success")
        }
        
    }
}
