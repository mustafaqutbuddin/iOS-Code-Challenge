//
//  BasicInfoCell.swift
//  iOS Code Challenge
//
//  Created by Mustafa on 29/08/2020.
//  Copyright © 2020 Mustafa. All rights reserved.
//

import UIKit

enum TextFieldData: Int {
    case userNameTextField = 0
    case firstNameTextField = 1
    case lastNameTextField = 2
    case oldPassTextField = 3
    case newPassTextField = 4
    case confirmPassTextField = 5
}

class BasicInfoCell: UITableViewCell {
    
    var profileData: ProfileModel?
    
    //MARK: - Views
    
    let dataTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    var dataLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var placeholder: String? {
        didSet {
            guard let placeholder = placeholder else {return}
            dataTextField.placeholder = placeholder
        }
    }
    
    
    //MARK: - Cell methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView(withViews views: [UIView]) {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, widht: 0, height: 50)
    }
    
    public func populateCell(withIndexPath indexPath: IndexPath, data: [TableDataModel]) {
        
        placeholder = data[indexPath.row].placeholder
        dataLabel.text = data[indexPath.row].label
        setupStackView(withViews: [dataLabel, dataTextField])
        
        switch dataTextField.tag {
        case 0:
            dataTextField.text = self.profileData?.data.userName
        case 1:
            dataTextField.text = self.profileData?.data.firstName
        case 2:
            dataTextField.text = self.profileData?.data.lastName
        default:
            break
        }
    }
    
}

