//
//  HomeView.swift
//  Geofire
//
//  Created by Tee Becker on 11/12/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionStore
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            if (session.session != nil) {
                
                VStack(spacing: 10) {
                    Text("GOOD TO SEE YOU!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.orange)
                        .padding()
                    
                    Button(action:{
                        session.signOut()
                        
                    }) {
                        Text("Sign Out")
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.2))
                .edgesIgnoringSafeArea(.all)
                
            } else {
                
                LoginView()
                
            }
        
                
        }
        .onAppear(perform: getUser)

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
