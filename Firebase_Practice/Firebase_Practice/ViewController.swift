//
//  ViewController.swift
//  Firebase_Practice
//
//  Created by jang gukjin on 2019/12/16.
//  Copyright © 2019 jang gukjin. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

    // MARK: Property
    lazy var emailTextField = UITextField()
    lazy var passwordTextField = UITextField()
    lazy var loginButton = UIButton()
    lazy var googleLoginButton = GIDSignInButton()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance().signIn()
        
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(googleLoginButton)
        
        // MARK: View - Constraints
        emailTextField.backgroundColor = UIColor.white
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.snp.makeConstraints{ (make) in
            make.width.equalTo(230)
            make.height.equalTo(48)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view)
        }
        
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.snp.makeConstraints{ (make) in
            make.width.equalTo(230)
            make.height.equalTo(48)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        loginButton.backgroundColor = UIColor(red: 122/255, green: 129/255, blue: 255/255, alpha: 1)
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = loginButton.titleLabel?.font.withSize(15)
        loginButton.layer.cornerRadius = 10
        loginButton.titleEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        loginButton.snp.makeConstraints{ (make) in
            make.width.equalTo(230)
            make.height.equalTo(48)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        loginButton.addTarget(self, action: #selector(touchUpLoginButton(_:)), for: .touchUpInside)
        
        googleLoginButton.backgroundColor = .white
        googleLoginButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(230)
            make.height.equalTo(48)
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        googleLoginButton.addTarget(self, action: #selector(touchUpGoogleLoginButton(_:)), for: .touchUpInside)
    }

    // MARK: Custom Method
    @objc
    func touchUpLoginButton(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            if error != nil { return }
            
            let alert = UIAlertController(title: "알림", message: "회원가입완료", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion:  nil)
        }
    }
    
    @objc
    func touchUpGoogleLoginButton(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
    }
}

