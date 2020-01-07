//
//  SignUpViewController.swift
//  Firebase_Practice
//
//  Created by jang gukjin on 2020/01/07.
//  Copyright © 2020 jang gukjin. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class SignUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Property
    lazy var topBar = UIView()
    lazy var cancleButton = UIButton()
    lazy var doneButton = UIButton()
    
    lazy var tableView = UITableView()
    lazy var inputEmail = UITextField()
    lazy var inputPassword = UITextField()
    lazy var inputName = UITextField()
    lazy var inputGender = UITextField()
    lazy var inputAddress = UITextField()
    lazy var inputPhoneNumber = UITextField()
    lazy var genderPickerView = UIPickerView()
    
    let pickerData = ["Man", "Woman", "ETC"]
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.genderPickerView.delegate = self
        self.genderPickerView.dataSource = self
        
        self.view.addSubview(topBar)
        self.topBar.addSubview(cancleButton)
        self.topBar.addSubview(doneButton)
        
        self.view.addSubview(tableView)
        
        self.view.addSubview(inputEmail)
        self.view.addSubview(inputPassword)
        self.view.addSubview(inputName)
        self.view.addSubview(inputAddress)
        self.view.addSubview(inputPhoneNumber)
        self.view.addSubview(inputGender)
        self.view.addSubview(genderPickerView)
        
//        genderPickerView.isHidden = true
        genderPickerView.alpha = 0.0
        
        // MARK: View - Constraints
        topBar.backgroundColor = .systemBackground
        topBar.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(50)
        }
        
        cancleButton.setTitle("Cancle", for: .normal)
        cancleButton.setTitleColor(.systemBlue, for: .normal)
        cancleButton.snp.makeConstraints{ (make) in
            make.top.left.equalTo(topBar).offset(10)
        }
        cancleButton.addTarget(self, action: #selector(touchUpCancleButton(_:)), for: .touchUpInside)
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.systemBlue, for: .normal)
        doneButton.snp.makeConstraints{ (make) in
            make.top.equalTo(topBar.snp.top).offset(10)
            make.right.equalTo(topBar.snp.right).offset(-20)
        }
        doneButton.addTarget(self, action: #selector(touchUpDoneButton(_:)), for: .touchUpInside)
        
        inputEmail.autocapitalizationType = .none
        inputEmail.backgroundColor = UIColor.white
        inputEmail.placeholder = "Email"
        inputEmail.borderStyle = .roundedRect
        inputEmail.snp.makeConstraints{ (make) in
            make.width.equalTo(270)
            make.height.equalTo(48)
            make.top.equalTo(doneButton.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
        
        inputPassword.autocapitalizationType = .none
        inputPassword.backgroundColor = UIColor.white
        inputPassword.placeholder = "Password"
        inputPassword.borderStyle = .roundedRect
        inputPassword.isSecureTextEntry = true
        inputPassword.snp.makeConstraints{ (make) in
            make.width.equalTo(270)
            make.height.equalTo(48)
            make.top.equalTo(inputEmail.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        inputName.autocapitalizationType = .none
        inputName.backgroundColor = UIColor.white
        inputName.placeholder = "Name"
        inputName.borderStyle = .roundedRect
        inputName.snp.makeConstraints{ (make) in
            make.width.equalTo(270)
            make.height.equalTo(48)
            make.top.equalTo(inputPassword.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        inputAddress.autocapitalizationType = .none
        inputAddress.backgroundColor = UIColor.white
        inputAddress.placeholder = "Address"
        inputAddress.borderStyle = .roundedRect
        inputAddress.snp.makeConstraints{ (make) in
            make.width.equalTo(270)
            make.height.equalTo(48)
            make.top.equalTo(inputName.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        inputPhoneNumber.backgroundColor = UIColor.white
        inputPhoneNumber.placeholder = "PhoneNumebr"
        inputPhoneNumber.borderStyle = .roundedRect
        inputPhoneNumber.snp.makeConstraints{ (make) in
            make.width.equalTo(270)
            make.height.equalTo(48)
            make.top.equalTo(inputAddress.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        inputGender.backgroundColor = UIColor.white
        inputGender.placeholder = "Gender"
        inputGender.borderStyle = .roundedRect
        inputGender.snp.makeConstraints{ (make) in
            make.width.equalTo(270)
            make.height.equalTo(48)
            make.top.equalTo(inputPhoneNumber.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        inputGender.addTarget(self, action: #selector(beginEditGenderTextfield(_:)), for: .editingDidBegin)
        inputGender.addTarget(self, action: #selector(endEditGenderTextfield(_:)), for: .editingDidEnd)
        
        genderPickerView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        genderPickerView.layer.cornerRadius = 4
        genderPickerView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
        genderPickerView.layer.borderWidth = 0.7
        genderPickerView.snp.makeConstraints{ (make) in
            make.width.equalTo(270)
            make.height.equalTo(80)
            make.top.equalTo(inputGender.snp.bottom)
            make.centerX.equalTo(view)
        }
    }

    // MARK: Custom Method
    @objc
    func touchUpCancleButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func touchUpDoneButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func beginEditGenderTextfield(_ sender: UITextField) {
//        genderPickerView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.genderPickerView.alpha = CGFloat(1.0)
        })
    }
    
    @objc
    func endEditGenderTextfield(_ sender: UITextField) {
//        genderPickerView.isHidden = true
        UIView.animate(withDuration: 0.2, animations: {
            self.genderPickerView.alpha = CGFloat(0.0)
        })
    }
    
    // MARK: PickerView Setting
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inputGender.text = pickerData[row]
    }
}
