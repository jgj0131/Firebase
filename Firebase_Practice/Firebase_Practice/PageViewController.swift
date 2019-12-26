//
//  PageViewController.swift
//  Firebase_Practice
//
//  Created by jang gukjin on 2019/12/18.
//  Copyright © 2019 jang gukjin. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class PageViewController: UIViewController {
    
    lazy var logOutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        self.view.addSubview(logOutButton)
        
        logOutButton.setTitle("Sign Out", for: .normal)
        logOutButton.setTitleColor(.black, for: .normal)
        logOutButton.snp.makeConstraints{ (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
//            make.width.equalTo(20)
//            make.height.equalTo(10)
        }
        logOutButton.addTarget(self, action: #selector(touchUpLogOutButton(_:)), for: .touchUpInside)
    }
    
    @objc
    func touchUpLogOutButton(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
