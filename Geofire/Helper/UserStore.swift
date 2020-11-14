//
//  UserStore.swift
//  Geofire
//
//  Created by Tee Becker on 11/14/20.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    // show avatar or not ( not using this for now)
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged"){
        didSet{
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
        
    }
    
    // show or hide loginScreen
    @Published var showLoginView = false
    @Published var showSignUpView = false

}

