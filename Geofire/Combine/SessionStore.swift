//
//  SessionStore.swift
//  Geofire
//
//  Created by Tee Becker on 11/11/20.
//

import SwiftUI
import Firebase
import Combine

// shared across several view
class SessionStore: ObservableObject{
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User?{
        didSet {
            self.didChange.send(self)
        }
    }
    var handle: AuthStateDidChangeListenerHandle?
    
    //Gets called whenever the user's sign-in state changes.
    func listen(){
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user{
                self.session = User(uid: user.uid, email: user.email)
            } else {
                self.session = nil
            }
        }
    }
    
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.session = nil
        }catch{
            print("error signing out")
        }
    }
    
    
    func unbind(){
        if let handle = handle{
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    
    deinit {
        unbind()
    }
    
    
}

struct User {
    var uid: String
    var email: String?
//    var firstname: String
//    var lastname: String
//    var password: String
//    var addressLine: String
//    var city: String
//    var state: String
//    var zipcode: String


    init(uid: String,
         email: String?
//         firstname:String,
//         lastname: String,
//         password: String,
//         address: String,
//         city: String,
//         state:String,
//         zipcode:String
    ) {
        self.uid = uid
        self.email = email
//        self.firstname = firstname
//        self.lastname = lastname
//        self.password = password
//        self.addressLine = address
//        self.city = city
//        self.state = state
//        self.zipcode = zipcode
    }
}
