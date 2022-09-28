//
//  User.swift
//  Uber-Swift-Full
//
//  Created by hakkı can şengönül on 28.09.2022.
//

import Foundation

struct User{
    let fullname: String
    let email: String
    let accountType: Int
    
    init(dictionary: [String: Any]) {
        fullname = dictionary["fullname"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
        accountType = dictionary["accountType"] as? Int ?? 0
    }
}
