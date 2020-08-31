//
//  ProfileViewModel.swift
//  iOS Code Challenge
//
//  Created by Mustafa on 30/08/2020.
//  Copyright © 2020 Mustafa. All rights reserved.
//

import UIKit

struct ProfileViewModel {
    let userName: String
    let firstName: String
    let lastName: String
    
    init(_ profile: ProfileModel) {
        self.userName = profile.data.userName
        self.firstName = profile.data.firstName
        self.lastName = profile.data.lastName
    }
}

