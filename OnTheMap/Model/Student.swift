//
//  Student.swift
//  OnTheMap
//
//  Created by Abdoulaye Diallo on 4/24/20.
//  Copyright © 2020 supergenedy. All rights reserved.
//

import Foundation

struct Students: Codable {
    let results: [Student]?
}

struct Student : Codable {
    var uniqueKey: String
    var objectId: String
    var firstName: String
    var lastName: String
    var longitude: Double
    var latitude: Double
    var mediaURL: String
}
