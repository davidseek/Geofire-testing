//
//  ContentView.swift
//  Geofire
//
//  Created by David Seek on 11/15/20.
//

import SwiftUI

/// This view is the general canvas of our application
/// From here, the status of the application defines
/// what view will be presented to the user
struct ContentView: View {
    
    /// We need to pass an AppManager instance
    /// that will define the whole view architecture
    @ObservedObject private var appManager: AppManager
    
    init(appManager: AppManager) {
        self.appManager = appManager
    }
    
    var body: some View {
        
        /// We need to wrap everything into a ZStack so the compiler is happy
        /// Logically tho there will never be more than one view visible
        ZStack {
            
            /// If the app is idling, we just want it to show the
            /// green-ish default background to show, that the app is ready
            if appManager.isIdling {
                Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
            }
            
            if appManager.isLoggingIn {
                LoginView(onAction: appManager.loginViewActionHandler)
            }
            
            if appManager.isRegistering {
                SignUpView(onAction: appManager.singUpViewActionHandler)
            }
            
            if appManager.isHome {
                HomeView(
                    locations: $appManager.geoLocations,
                    onAction: appManager.homeViewActionHandler)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appManager: AppManager())
    }
}
