//
//  Data.swift
//  Geofire
//
//  Created by Tee Becker on 11/13/20.
//
// 1. make a struct of what each profile contains

import SwiftUI


struct Profile: Codable{
    var name: String
    var email: String
}

class Api {
 
    func getProfile() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else{fatalError()}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let users = try! JSONDecoder().decode([Profile].self, from: data!)
            print(users)
        }
        .resume()
    }
    
}
