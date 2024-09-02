//
//  SignUp.swift
//  wabzhub_app
//
//  Created by Horia Zamfir on 27.08.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseAuthInternal
import FirebaseAuthInterop
import FirebaseCoreExtension
import FirebaseFirestore

struct SignUp: View {
    @StateObject private var userAuth = UserAuth()
    @State private var singInErrorMessage: String = "Password doesn't match"
    @State private var errorMessage: String?
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var signInErrorMessage: String = ""
    
    @State private var isErrorVisible: Bool = false
    @State private var passwordMatches: Bool = false
    @State private var isSignedup: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                Image("LogoWabz")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240, height: 180)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 30)
                    .padding(.top, 10)
                
                VStack(alignment: .leading) {
                    Text("**Signup**")
                        .font(.largeTitle)
                    Text("Please sign up to continue")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                }.padding(.leading, 10)
                
                //EMAIL INPUT
                VStack {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.gray)
                        
                        TextField("Email", text: $email)
                            .padding(.leading, 5)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
                
                //PASSWORD INPUT
                VStack {
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                        
                        SecureField("Password", text: $password)
                            .padding(.leading, 5)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)

                }
                
                //PASWORD INPUT X2
                VStack {
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding(.leading, 5)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
                
                if isErrorVisible {
                    Text(errorMessage ?? "An error occurred")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                //SIGN UP BUTTON
                Button(action: {
//                    userAuth.signIn(email: email, password: password)
                    signUpUser(email: email, password: password)
                }) {
                    HStack {
                        Text("Signup")
                            .font(.headline)
                            .foregroundColor(.white)
                        Image(systemName: "arrow.right")
                            .font(.headline)
                            .foregroundColor(.white)
                        }
                        .padding()
                        .frame(width: 160, height: 50)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.orange, Color.yellow]),
                                startPoint: .leading,
                                endPoint: .trailing
                                )
                         )
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 10)
                }
                .navigationDestination(isPresented: $isSignedup) {
                    UserProfile()
                }
                Spacer()
                Text("By signing up, you agree to our Terms of Service and Privacy Policy")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .padding(.bottom, 10)
                
                NavigationLink(destination: ContentView()){
                    Text("Already have an account? **Sign In**")
                        .foregroundColor(.orange)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.light)
    }
    
    
    /*
     FUNCTIONS FOR SIGN UP:
     --- Sign Up the User with Firebase
     --- Save additional user info to Firestore
     --- Validate User Input
     ---  Save additional user info to Firestore
     */
    
    
    
    /*
     Sign Up the User with Firebase
     */
    func signUpUser(email: String, password: String) {
        guard validateInput() else {
            showError()
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = "Failed to sign up: \(error.localizedDescription)"
                showError()
            } else {
                isSignedup = true
                // Optionally save additional user info to Firestore or Realtime Database
                saveAdditionalUserInfo()
            }
        }
    }
    
    /*
     Save additional user info to Firestore
     */
    func saveAdditionalUserInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).setData([
            "email": self.email
        ]) { error in
            if let error = error {
                print("Error saving user data: \(error)")
            } else {
                print("User data successfully saved!")
            }
        }
    }
    
    /*
     Save additional user info to Firestore
     */
    func showError() {
        isErrorVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            isErrorVisible = false
        }
    }
    
    /*
     Validate User Input
     Check List:
     --- Valid email address
     --- Matching password
     --- 6 long Password
     TO DO:
     --- Password with capital letter
     --- Password must contain special character
     */
    private func validateInput() -> Bool {
        guard email.contains("@") else {
            errorMessage = "Invalid email address"
            return false
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long"
            return false
        }
        
        errorMessage = nil
        return true
    }
}

struct SignUp_Preview: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
