//
//  AppManager.swift
//  Geofire
//
//  Created by David Seek on 11/15/20.
//

import Foundation

/// AppState literally defines the state our app is in
private enum AppState {
    
    /// Idle is the status when the application itself is idling
    /// but computation or networks requests are working
    /// A typical example is checking if the user is logged in or not
    case idle
    /// Home indicates the user is logged in
    /// and the application is waiting for user input
    case home
    /// Self explanatory
    case login
    /// Self explanatory
    case registration
}

/// The AppManager is the brain of our application
/// Here we'll have the current states stored
/// and used accross the application to define the UI
class AppManager: ObservableObject {
    
    private let authManager = AuthManager()
    private var state: AppState = .idle {
        willSet {
            objectWillChange.send()
        }
        didSet {
            print("Did update state to: \(state)")
        }
    }
    
    public var isIdling: Bool { return state == .idle }
    public var isHome: Bool { return state == .home }
    public var isLoggingIn: Bool { return state == .login }
    public var isRegistering: Bool { return state == .registration }
    
    init() {
        setAuthObserver()
    }
    
    /// For now we will handle all the logic in the AppManager
    /// Once the app grows too large, we'd create dedicated managers
    /// for each part of the logic. Like LoginManager
    
    // MARK: - public
    
    public func loginViewActionHandler(action: LoginViewAction) {
        switch action {
        case .didRequestLogin(let email, let password):
            authManager.login(email, password: password)
        case .didRequestRegistration:
            updateState(to: .registration)
        }
    }
    
    public func singUpViewActionHandler(action: SignUpViewAction) {
        switch action {
        case .didRequestSignUp(let email, let password, let payload):
            authManager.register(email, password: password, payload: payload)
        case .didCancelSignUp:
            updateState(to: .login)
        }
    }
    
    public func homeViewActionHandler(action: HomeViewAction) {
        switch action {
        case .didRequestLogout:
            authManager.logout()
        }
    }
    
    // MARK: - Private
    
    private func setAuthObserver() {
        authManager.observeAuthState { [weak self] user in
            print("auth state did change")
            let newState: AppState = (user == nil) ? .login : .home
            self?.updateState(to: newState)
        }
    }
    
    /// Wrapper frunction so we dont have to call DispatchQueue all the time
    private func updateState(to state: AppState) {
        DispatchQueue.main.async { [weak self] in
            self?.state = state
        }
    }
}
