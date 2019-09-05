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
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passTextFieldHeightAnchor: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
       
        self.setupInputContainerView()
        self.setupLoginRegisterButton()
        self.setupLoginRegisterSegmentedControl()
        self.setupProfileImageView()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
