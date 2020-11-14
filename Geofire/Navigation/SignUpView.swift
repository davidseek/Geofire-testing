//
//  SignUpView.swift
//  Geofire
//
//  Created by Tee Becker on 11/11/20.


import SwiftUI
import FirebaseDatabase

struct SignUpView: View {
    @State var database: DatabaseReference!
    @EnvironmentObject var session: SessionStore
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var password = ""
    @State var error = ""
    @State var addressLine = ""
    @State var city = ""
    @State var state = ""
    @State var zipcode = ""
    @State var signUpSuccessful = false
    
    
    func signup(){
        
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
        
        signUpToFirebase()
        
        signUpSuccessful = true
    }
    
    
    func signUpToFirebase(){
        
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error{
                self.error = error.localizedDescription
                return
                
            } else {
                self.email = ""
                self.password = ""
            }
        }
        
        addToDatabase()
    }
    
    
    func addToDatabase(){
        database = Database.database().reference()
        guard let key = database.childByAutoId().key else{return}
        
        let userData: [String: Any] = [
            "id": key,
            "name": firstname + lastname,
            "email": email,
            "address": addressLine + ", " + city + ", " + state.uppercased() + " " + zipcode
            // add long and lat here
        ]
        
        database.child(key).setValue(userData)
    }
    
    //    func signup(){
    //        session.signUp(email: email, password: password) { (result, error) in
    //            if let error = error{
    //                self.error = error.localizedDescription
    //                return
    //            } else {
    //                self.email = ""
    //                self.password = ""
    //            }
    //        }
    //
    //        addToDatabase()
    //    }
    
    var body: some View {
        
        ZStack {
            VStack {
                VStack {
                    Text("SIGN UP")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 60)
                }
                .frame(width: screen.width, height: screen.height / 10 )
                
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
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)).opacity(0.2))
            .edgesIgnoringSafeArea(.all)
            
            if signUpSuccessful{
                HomeView()
            }
        }
    }
}


// MARK: Subviews
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionStore())
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

