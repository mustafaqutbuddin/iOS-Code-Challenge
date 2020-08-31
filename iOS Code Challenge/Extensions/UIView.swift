//
//  UIView.swift
//  iOS Code Challenge
//
//  Created by Mustafa on 29/08/2020.
//  Copyright © 2020 Mustafa. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, widht: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            if #available(iOS 11.0, *) {
                self.safeAreaLayoutGuide.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            } else {
                self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            }

        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if widht != 0 {
            self.widthAnchor.constraint(equalToConstant: widht).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
