//
//  AuthView.swift
//  Geofire
//
//  Created by Tee Becker on 11/11/20.
//  Auth view

import SwiftUI

struct LoginView: View {
    @State var registeredEmail = ""
    @State var registeredPassword = ""
    @State var error = ""
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var user: UserStore
    
    
    func saveToUserDefault(){
        UserDefaults.standard.set(true, forKey: "isLogged")
    }
    
    func signin(){
        session.signIn(email: registeredEmail, password: registeredPassword) { (result, error) in
            
            if let error = error{
                self.error = error.localizedDescription
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { self.error = "" }
            } else{
                self.registeredEmail = ""
                self.registeredPassword = ""
                user.isLogged = true
                saveToUserDefault()
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 30) {
                WelcomeText()
                
                //Textfield UI
                TextfieldView(registeredEmail: $registeredEmail, registeredPassword: $registeredPassword)
                
                Button(action:{
                    signin()
                }) {
                    Text("LOGIN")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 120, height: 50)
                        .background(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
                
                
                VStack {
                    HStack{
                        Text("I am a new user")
                            .font(.subheadline)
                        
                        Button(action:{
                            user.showSignUpView = true
                        }) {
                            Text("Create an acount")
                                .font(.title3)
                                .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                        }
                        
                    }
                    
                    if (error != ""){
                        Text(error)
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)).opacity(0.2))
            .edgesIgnoringSafeArea(.all)
            
            
            if user.showSignUpView {
                SignUpView()
            }
            
            if user.isLogged {
                HomeView()
            }
            
        }
    }
}

// MARK: Subviews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(SessionStore())
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

struct TextfieldView: View {
    @Binding var registeredEmail: String
    @Binding var registeredPassword: String
    
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
                
                TextField("YOUR EMAIL", text: $registeredEmail)
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
                
                
                
                SecureField("PASSWORD", text: $registeredPassword)
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
