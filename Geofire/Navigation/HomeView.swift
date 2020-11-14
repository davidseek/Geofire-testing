//
//  HomeView.swift
//  Geofire
//
//  Created by Tee Becker on 11/12/20.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var user: UserStore
    @State var currentAddress = ""
    
    
    var body: some View {
        
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                HStack {
                    TextField("Enter an address", text: $currentAddress)
                        .font(.title2)
                        .frame(height: 45)
                        .padding(.leading)
                    
                    Button(action: {
                        
                        CoordinateConvert().convertAddressToCoords(for: currentAddress) { (location) in
                            print("Longitude is \(String(describing: location?.longitude))")
                            print("Latitude is: \(String(describing: location?.latitude))")
                        }
                    }) {
                        Text("Search")
                    }
                    .frame(height: 45)
                    .padding(.leading)
                    .padding(.trailing)
                    
                }
                
                VStack {
                    Text("List of items that fits the criteria")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.orange)
                        .frame(height: screen.height * 0.7)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                
                Button(action:{
                    session.signOut()
                    UserDefaults.standard.set(false, forKey: "isLogged")
                    user.isLogged = false
                    user.showLoginView = true
                    
                }) {
                    Text("Sign Out")
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.2))
            .edgesIgnoringSafeArea(.all)
            
            
            if user.showLoginView {
                LoginView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionStore()).environmentObject(UserStore())
    }
}
