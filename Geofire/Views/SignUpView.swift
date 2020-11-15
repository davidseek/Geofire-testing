//
//  SignUpView.swift
//  Geofire
//
//  Created by Tee Becker on 11/11/20.


import SwiftUI
import FirebaseDatabase

/// We do not want the View layer to handle any actions
/// That's why we're just emiting whatever action took place
/// to the logical layers of the application
/// Separation of concerns
enum SignUpViewAction {
    case didRequestSignUp(email: String, password: String, payload: RegistrationPayload)
    case didCancelSignUp
}

struct SignUpView: View {
    
    /// The action handler we will trigger when anything happens
    /// We'll make it optional so the preview isn't losing it's shit
    private let actionHandler: ((SignUpViewAction) -> Void)?
    
    /// RegistrationPayload information
    @State var firstname = ""
    @State var lastname = ""
    @State var addressLine = ""
    @State var city = ""
    @State var state = ""
    @State var zipcode = ""
    
    @State var email = ""
    @State var password = ""
    @State var error = ""
    
    init(onAction: ((SignUpViewAction) -> Void)? = nil) {
        actionHandler = onAction
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                /// The first layer must be the background color
                /// So we can have the inner views with padding applied
                Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        Text("SIGN UP")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 60)
                            .frame(width: geometry.size.width, height: geometry.size.height / 10 )
                        
                        HStack {
                            Spacer()
                            Image(systemName: "xmark")
                                .frame(width: 36, height:36)
                                .foregroundColor(.white)
                                .background(Color.black.clipShape(Circle()))
                        }
                        .padding()
                        .onTapGesture {
                            actionHandler?(.didCancelSignUp)
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Textfield(text: $firstname, systemName: "person.circle.fill", placeholderText: "firstname")
                        Textfield(text: $lastname, systemName: "person.circle.fill", placeholderText: "lastname")
                        Textfield(text: $email, systemName: "person.circle.fill", placeholderText: "email")
                        Textfield(text: $password, systemName: "person.circle.fill", placeholderText: "password")
                        Textfield(text: $addressLine, systemName: "person.circle.fill", placeholderText: "Street address")
                        Textfield(text: $city, systemName: "person.circle.fill", placeholderText: "city")
                        Textfield(text: $state, systemName: "person.circle.fill", placeholderText: "state")
                        Textfield(text: $zipcode, systemName: "person.circle.fill", placeholderText: "zip")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    if (error != ""){
                        Text(error)
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .padding(.all)
                    }
                    
                    Button(action: {
                        signup()
                    }) {
                        Text("SIGN UP")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(width: 120, height: 50)
                    .background(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .padding(.bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
    // MARK: - Private
    
    /// Not best practice
    /// We shouldnt have any logic in the view layers
    /// But we can look into this later
    /// Don't want to change too much shit
    private func signup(){
        // check for empty fields
        if firstname.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastname.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            addressLine.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            city.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            state.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            zipcode.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            error = "please fill in all fields"
            return
        }
        
        //check for valid password
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanPassword) == false{
            error = " Please make sure to include special characters and numbers in your password"
            return
        }
        
        actionHandler?(.didRequestSignUp(email: email, password: password, payload: getRegistrationPayload()))
    }
    
    private func getRegistrationPayload() -> RegistrationPayload {
        return RegistrationPayload(
            firstname: firstname,
            lastname: lastname,
            email: email,
            addressLine: addressLine,
            city: city,
            state: state,
            zipcode: zipcode)
    }
}


// MARK: Subviews
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


struct Textfield: View {
    @Binding var text: String
    
    var systemName: String
    var placeholderText: String
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .font(.title)
                .frame(width: 44, height: 44)
                //                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                .padding(.vertical, 1)
            
            
            TextField(placeholderText.uppercased(), text: $text)
                .autocapitalization(.none)
                .font(.body)
                //                .padding(.all)
                .frame(height: 44)
        }
        Divider()
    }
}

