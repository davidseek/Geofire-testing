//
//  RegistrationPayload.swift
//  Geofire
//
//  Created by David Seek on 11/15/20.
//

import Foundation

struct RegistrationPayload: Codable {
    var firstname: String
    var lastname: String
    var email: String
    var addressLine: String
    var city: String
    var state: String
    var zipcode: String
}
