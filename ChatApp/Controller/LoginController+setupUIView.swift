//
//  LoginController+setupUIView.swift
//  ChatApp
//
//  Created by Nazim Uddin on 4/9/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

extension LoginController{
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
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150.0)
        inputsContainerViewHeightAnchor?.isActive = true
        
        // setup sub inputsContainerView
        setupNameTextField()
        setupSeparatorView(bottomAnchor: nameTextField.bottomAnchor)
        setupEmailTextField()
        setupSeparatorView(bottomAnchor: emailTextField.bottomAnchor)
        setupPasswordTextField()
    }
    func setupProfileImageView(){
        profileImageView.image = UIImage(named: "profile.png")
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        profileImageView.isUserInteractionEnabled = true
        view.addSubview(profileImageView)
        
        //need x, y, width, height constraints
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupNameTextField(){
        nameTextField.placeholder = "Name"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        inputsContainerView.addSubview(nameTextField)
        
        //need x, y, width, height constraints
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        
        nameTextFieldHeightAnchor?.isActive = true
        
    }
    func setupEmailTextField(){
        emailTextField.placeholder = "Email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        inputsContainerView.addSubview(emailTextField)
        
        //need x, y, width, height constraints
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
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
        passTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passTextFieldHeightAnchor?.isActive = true
        
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
        loginRegisterButton.addTarget(self, action: #selector(hendleLoinRegister), for: .touchUpInside)
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
        loginRegisterSegmentControl.tintColor = UIColor.white
        loginRegisterSegmentControl.selectedSegmentIndex = 1
        loginRegisterSegmentControl.addTarget(self, action: #selector(hendleLoginRegisterChange), for: .valueChanged)
        loginRegisterSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginRegisterSegmentControl)
        
        //need x, y, width, height constraints
        loginRegisterSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

