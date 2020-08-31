//
//  ViewController.swift
//  iOS Code Challenge
//
//  Created by Mustafa on 29/08/2020.
//  Copyright © 2020 Mustafa. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private let basicInfoCellId = "basicInfo"
    private let passwordCellId = "passCellId"
    private let bioData: [TableDataModel] = [
        TableDataModel(label: "Username", placeholder: "Enter username"),
        TableDataModel(label: "First Name", placeholder: "Enter first name"),
        TableDataModel(label: "Last Name", placeholder: "Enter last name")
    ]
    private let passData: [TableDataModel] = [
        TableDataModel(label: "Old Password", placeholder: "Enter old password"),
        TableDataModel(label: "New Password", placeholder: "Enter new password"),
        TableDataModel(label: "Re-enter Password", placeholder: "Re-enter password")
    ]
    
    
    
    private var profileData: ProfileModel?
    private var passwordModel = PasswordModel()
    
    private let webService: Webservice = {
        return MockApiClient()
    }()
    
    
    //MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.backgroundColor = .rgb(red: 141, green: 32, blue: 35)
        tableView.allowsSelection = false
        tableView.keyboardDismissMode = .onDrag
        setupNavBar(withTitle: "User Profile")
        registerTableCell()
        
        //call mock api
        fetchProfilesApi()
        
        
    }
    
    
    //MARK: - Utils
    private func setupHeaderView(withHeaderLabel headerLabel: String) -> UIView {
        let view = UIView()
        let label = UILabel()
        
        label.text = headerLabel.uppercased()
        
        view.backgroundColor = .systemGray6
        view.addSubview(label)
        
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, widht: 0, height: 0)
        
        return view
    }
    
    private func setupFooterView(buttonHandler: Selector) -> UIView {
        let view = UIView()
        let button = UIButton()
        
        
        button.setTitle("Save changes".uppercased(), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: buttonHandler, for: .touchUpInside)
        
        
        view.addSubview(button)
        
        button.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, widht: 200, height: 50)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        return view
        
    }
    
    //MARK: - Action events
    @objc func handleSaveBasicInfo() {
        webService.updateProfile(withData: profileData!) { profileData in
            self.profileData = profileData
            self.alertController(withTitle: "Success!", message: "Profile updated successfully!")
        }
    }
    
    @objc func handleSavePassword() {
        
        let isFormValid = passwordModel.oldPass.count > 0 && passwordModel.newPass.count  > 0 && passwordModel.confirmPass.count > 0
        
        let passValid = passwordModel.newPass == passwordModel.confirmPass
        
        if(!isFormValid) {
            self.alertController(withTitle: "Error!", message: "Please fill in all the required values")
            return
        }
        
        if !(passValid) {
            self.alertController(withTitle: "Error!", message: "New pass and confirm pass donot match")
            return
        }
        
        if isFormValid && passValid {
            webService.changePass(withParams: self.passwordModel.dictionary!) { (success, responseObj) in
                self.alertController(withTitle: "", message: responseObj?["message"] as! String)
            }
        }
        
    }
    
    //MARK: - Tableview data source methods
    private func registerTableCell() {
        self.tableView.register(BasicInfoCell.self, forCellReuseIdentifier: basicInfoCellId)
        self.tableView.register(PasswordCell.self, forCellReuseIdentifier: passwordCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bioData.count
        } else {
            return passData.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let basicInfoCell = tableView.dequeueReusableCell(withIdentifier: basicInfoCellId, for: indexPath) as! BasicInfoCell
            
            
            basicInfoCell.dataTextField.tag = indexPath.row
            basicInfoCell.dataTextField.delegate = self
            
            
            guard let profileData = self.profileData else {return basicInfoCell}
            basicInfoCell.profileData = profileData
            basicInfoCell.populateCell(withIndexPath: indexPath, data: bioData)
            
            return basicInfoCell
        } else {
            
            let passCell = tableView.dequeueReusableCell(withIdentifier: passwordCellId, for: indexPath) as! PasswordCell
            
            passCell.dataTextField.tag = indexPath.row + 3
            passCell.dataTextField.delegate = self
            passCell.placeholder = passData[indexPath.row].placeholder
            passCell.dataLabel.text = passData[indexPath.row].label
            passCell.setupStackView(withViews: [passCell.dataLabel, passCell.dataTextField])
            
            return passCell
        }
    }
    
    //MARK: - Tableview delegate methods
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return setupHeaderView(withHeaderLabel: "Basic information")
        } else  {
            return setupHeaderView(withHeaderLabel: "Password")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return setupFooterView(buttonHandler: #selector(handleSaveBasicInfo))
        } else {
            return setupFooterView(buttonHandler: #selector(handleSavePassword))
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    //MARK: - Networking
    private func fetchProfilesApi() {
        webService.fetchProfile { success, profileData in
            self.profileData = profileData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func valueChanged(_ textField: UITextField) {
        switch textField.tag {
        case TextFieldData.userNameTextField.rawValue:
            self.profileData?.data.userName = textField.text!
        case TextFieldData.firstNameTextField.rawValue:
            self.profileData?.data.firstName = textField.text!
        case TextFieldData.lastNameTextField.rawValue:
            self.profileData?.data.lastName = textField.text!
        case TextFieldData.oldPassTextField.rawValue:
            textField.isSecureTextEntry = true
            self.passwordModel.oldPass = textField.text!
        case TextFieldData.newPassTextField.rawValue:
            textField.isSecureTextEntry = true
            self.passwordModel.newPass = textField.text!
        case TextFieldData.confirmPassTextField.rawValue:
            textField.isSecureTextEntry = true
            self.passwordModel.confirmPass = textField.text!
        default:
            break
        }
        
    }
}

//MARK:- Textfield delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }
}

