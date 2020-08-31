//
//  PasswordModel.swift
//  iOS Code Challenge
//
//  Created by Mustafa on 31/08/2020.
//  Copyright © 2020 Mustafa. All rights reserved.
//

import Foundation

struct PasswordModel: Encodable {
    var oldPass: String
    var newPass: String
    var confirmPass: String
    
    init(oldPass: String = "", newPass: String = "", confirmPass: String = "") {
        self.oldPass = oldPass
        self.newPass = newPass
        self.confirmPass = confirmPass
    }
}
