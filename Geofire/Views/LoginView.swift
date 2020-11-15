//
//  AuthView.swift
//  Geofire
//
//  Created by Tee Becker on 11/11/20.
//  Auth view

import SwiftUI

/// We do not want the View layer to handle any actions
/// That's why we're just emiting whatever action took place
/// to the logical layers of the application
/// Separation of concerns
enum LoginViewAction {
    case didRequestLogin(email: String, password: String)
    case didRequestRegistration
}

struct LoginView: View {
    
    /// The action handler we will trigger when anything happens
    /// We'll make it optional so the preview isn't losing it's shit
    private let actionHandler: ((LoginViewAction) -> Void)?
    
    @State var email = ""
    @State var password = ""
    @State var error = ""
    
    init(onAction: ((LoginViewAction) -> Void)? = nil) {
        actionHandler = onAction
    }
    
    var body: some View {
        
        GeometryReader { geometry in
         
            ZStack {
                VStack(spacing: 30) {
                    getWelcomeText(in: geometry)
                    getLoginMask()
                    
                    Button(action:{
                        actionHandler?(.didRequestLogin(email: email, password: password))
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
                                actionHandler?(.didRequestRegistration)
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
            }
        }
    }
    
    // MARK: - Private
    
    private func getWelcomeText(in proxy: GeometryProxy) -> some View {
        return VStack {
            Text("WELCOME BACK!")
                .font(.largeTitle)
                .bold()
                .padding(.top, 60)
            
            Text("Sign in to continue")
                .font(.subheadline)
        }
        .frame(width: proxy.size.width, height: proxy.size.height / 5 )
    }
    
    private func getLoginMask() -> some View {
        return VStack(spacing: 6) {
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
                
                
                
                SecureField("PASSWORD", text: $password)
                    .font(.body)
                    .autocapitalization(.none)
                    .padding(.leading)
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

// MARK: Subviews
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
