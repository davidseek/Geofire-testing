//
//  ResultsView.swift
//  Geofire
//
//  Created by Tee Becker on 11/11/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        
        Group{
            if (session.session != nil) {
                Text("HEY! Welcome back")
                
                Button(action:
                        session.signOut
                ) {
                    Text("Sign Out")
                }
            } else {
                LoginView()
            }
        }
        .onAppear(perform: getUser)
        
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
