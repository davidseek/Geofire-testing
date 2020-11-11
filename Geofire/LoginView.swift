//
//  ContentView.swift
//  Geofire
//
//  Created by Tee Becker on 11/11/20.
//

import SwiftUI

struct LoginView: View {
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 30) {
                WelcomeText()
                
                Textfields()
                
                Button(action: {}) {
                    Text("LOGIN")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(width: 120, height: 50)
                .background(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))

                
                HStack{
                    Text("I am a new user")
                        .font(.subheadline)
                    
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Create an acount")
                            .font(.title3)
                            .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                    }
                }
                
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)).opacity(0.2))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct Textfields: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)))
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                    .padding(.leading)
                
                TextField("YOUR EMAIL", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .font(.body)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .padding(.leading)
                    .frame(height: 44)
            }
            
            Divider()
            
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)))
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                    .padding(.leading)
                
                
                // MARK: important* use SecureField instead of normal TextField
                SecureField("PASSWORD", text: $password)
                    .font(.body)
                    .autocapitalization(.none)
                    .padding(.leading)
                    .frame(height: 44)
            }
        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .background(Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
        .padding(.horizontal)
    }
}

let screen = UIScreen.main.bounds

struct WelcomeText: View {
    var body: some View {
        VStack {
            Text("WELCOME BACK!")
                .font(.largeTitle)
                .bold()
                .padding(.top, 60)
            
            Text("Sign in to continue")
                .font(.subheadline)
        }
        .frame(width: screen.width, height: screen.height / 5 )
    }
}
