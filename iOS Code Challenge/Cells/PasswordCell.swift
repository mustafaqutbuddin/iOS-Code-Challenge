//
//  PasswordCell.swift
//  iOS Code Challenge
//
//  Created by Mustafa on 31/08/2020.
//  Copyright © 2020 Mustafa. All rights reserved.
//

import UIKit

class PasswordCell: UITableViewCell {
    
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
}
