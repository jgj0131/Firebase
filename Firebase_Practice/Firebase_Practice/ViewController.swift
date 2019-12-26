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
    lazy var signUpButton = UIButton()
    
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
        self.view.addSubview(signUpButton)
        
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
        
        signUpButton.backgroundColor = .clear
        signUpButton.titleLabel?.font = loginButton.titleLabel?.font.withSize(15)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.darkGray, for: .normal)
        signUpButton.snp.makeConstraints{ (make) in
            make.width.equalTo(115)
            make.height.equalTo(48)
            make.top.equalTo(googleLoginButton.snp.bottom).offset(10)
            make.right.equalTo(googleLoginButton)
        }
        signUpButton.addTarget(self, action: #selector(signUp(_:)), for: .touchUpInside)
    }

    // MARK: Custom Method
    @objc
    func signUp(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            if error != nil { return }
            
            let alert = UIAlertController(title: "알림", message: "회원가입완료", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion:  nil)
            self.successLogin()
        }
    }
    
    @objc
    func touchUpLoginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if authResult != nil {
                self!.successLogin()
            } else {
                let alert = UIAlertController(title: "알림", message: "아이디나 비밀번호가 올바르지 않습니다.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self!.present(alert, animated: true, completion:  nil)
            }
          // ...
        }
//        self.successLogin()
//        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
//            if error != nil { return }
//
//            let alert = UIAlertController(title: "알림", message: "회원가입완료", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
//            self.present(alert, animated: true, completion:  nil)
//            self.successLogin()
//        }
    }
    
    @objc
    func touchUpGoogleLoginButton(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
        self.successLogin()
    }
    
    func successLogin() {
//        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//          // ...
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let pageView = storyboard.instantiateViewController(withIdentifier: "PageViewController")
                        pageView.modalPresentationStyle = .fullScreen
                //        pageView?.modalTransitionStyle = .coverVertical
                //        let pageViewController = PageViewController()
                        self.present(pageView, animated: true, completion: nil)
//        }
    }
}

