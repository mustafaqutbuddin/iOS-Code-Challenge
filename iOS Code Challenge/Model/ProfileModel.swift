//
//  ProfileModel.swift
//  iOS Code Challenge
//
//  Created by Mustafa on 30/08/2020.
//  Copyright © 2020 Mustafa. All rights reserved.
//

import Foundation

struct ProfileModel: Codable {
    
    let message: String
    var data: Profile
    
}

struct Profile: Codable {
    var firstName: String
    var userName: String
    var lastName: String
    
}
