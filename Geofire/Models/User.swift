//
//  Data.swift
//  Geofire
//
//  Created by Tee Becker on 11/13/20.
//
// 1. make a struct of what each profile contains

import SwiftUI

struct User {
    var uid: String
    var email: String?
    var firstname: String?
    var lastname: String?
    var password: String?
    var error: String?
    var addressLine: String?
    var city: String?
    var state: String?
    var zipcode: String?
}




//struct Profile: Codable{
//    var name: String
//    var email: String
//}
//
//class Api {
//
//    func getProfile() {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else{fatalError()}
//
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//            let users = try! JSONDecoder().decode([Profile].self, from: data!)
//            print(users)
//        }
//        .resume()
//    }
//
//}
