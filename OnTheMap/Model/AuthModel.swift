//
//  Auth.swift
//  OnTheMap
//
//  Created by Abdoulaye Diallo on 4/24/20.
//  Copyright © 2020 supergenedy. All rights reserved.
//

import Foundation

struct UserData: Codable {
    let user: User?
}

struct User: Codable {
    let first_name: String?
    let last_name: String?
}

struct Auth: Codable {
    let account: Account?
    let session: Session?
}

struct Account: Codable {
    let registered: Bool?
    let key: String?
}

struct Session: Codable {
    let id: String?
    let expiration: String?
}
