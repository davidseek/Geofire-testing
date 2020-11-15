//
//  SessionStore.swift
//  Geofire
//
//  Created by Tee Becker on 11/11/20.
//

import SwiftUI
import Firebase
import Combine

/// Formerly SessionStore, we now have a dedicated AuthManager
/// Makes in my opinion more sense
class AuthManager {
    private let database = Database.database().reference()
    private var authObserver: ((FirebaseAuth.User?) -> Void)?

    init() {
        setAuthObserver()
    }

    // MARK: - Public
    public func observeAuthState(_ observer: @escaping (FirebaseAuth.User?) -> Void) {
        authObserver = observer
    }

    public func login(_ email: String, password: String) {
        print("attempting login with \(email), \(password)")

        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                /// For now we just want to print the error
                /// We need to handle those kind of errors properly before beta
                print(error.localizedDescription)
            }
        }
    }
    
    public func register(_ email: String, password: String, payload: RegistrationPayload) {
        print("attempting register with \(email), \(password)")

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self?.uploadUser(payload)
        }
    }

    public func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            /// For now we just want to print the error
            /// We need to handle those kind of errors properly before beta
            print(error.localizedDescription)
        }
    }

    // MARK: - Private
    private func setAuthObserver() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.authObserver?(user)
        }
    }
    
    private func uploadUser(_ payload: RegistrationPayload){
        guard let key = database.childByAutoId().key else{
            return
        }
        guard let jsonData = try? FirebaseEncoder().encode(payload) else{
            return
        }
        /// We want to add the whole payload for later processing...
        /// And we want to add all users into a subfolder Users on the database...
        database.child("Users").child(key).setValue(jsonData)
    }
}
