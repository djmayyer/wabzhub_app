//
//  ContentView.swift
//  wabzhub_app
//
//  Created by Horia Zamfir on 26.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var singInErrorMessage: String = "Username or Password is incorrect"
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var signInErrorMessage: String = ""
    @State private var isErrorVisible: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                Image("LogoWabz")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240, height: 180)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 50)
                    .padding(.top, 10)
                
                VStack(alignment: .leading) {
                    Text("**Login**")
                        .font(.largeTitle)
                    Text("Please sign in to continue")
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
                        NavigationLink(destination: SignUp()){
                            Text("**FORGOT**")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
                
                if isErrorVisible {
                    Text("\(singInErrorMessage)")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Button(action: {
                    //Print email and password --- logs
                    print("Email: \(email), Password: \(password)")
                    // Perform login validation here
                    isLoggedIn = checkLogin(email: email, password: password)
                }) {
                    HStack {
                        Text("Login")
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
                .navigationDestination(isPresented: $isLoggedIn) {
                    UserProfile()
                }
                Spacer()
                NavigationLink(destination: SignUp()){
                    Text("Don't have an account? **Sign Up**")
                        .foregroundColor(.orange)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    /*
     Login Function
     */
    func checkLogin(email: String, password: String) -> Bool {
        print("Checking Login")
        if email == "Horia.zamfir@gmail.com" && password == "parola" {
            print("Success")
            return true
        } else {
            print("Failed")
            showError()
            return false
        }
    }
    /*
     Error Text
     */
    func showError() {
        print("showError")
        isErrorVisible = true
        // Hide the error message after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            isErrorVisible = false
        }
    }
}

/*
 View Extensions
 Used for viewing the phone on the right
 */
//extension View {
//    func pressAction(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
//        self.simultaneousGesture(
//            DragGesture(minimumDistance: 0)
//                .onChanged({ _ in onPress() })
//                .onEnded({ _ in onRelease() })
//        )
//    }
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//        SignUp()
////        HomeView()
//    }
//}

//#Preview {
//    ContentView()
//}
