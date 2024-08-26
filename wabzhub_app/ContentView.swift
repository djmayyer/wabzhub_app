//
//  ContentView.swift
//  wabzhub_app
//
//  Created by Horia Zamfir on 26.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Image("LogoWabz")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240, height: 180)
                
                Text("Login")
                    .font(.largeTitle)
                    .padding(.bottom, 40)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
//                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Button(action: {
                    //Print username and password --- logs
                    print("Username: \(username), Password: \(password)")
                    // Perform login validation here
                    isLoggedIn = true
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                .navigationDestination(isPresented: $isLoggedIn) {
                    HomeView()
                }
            }
            .padding()
        }
    }
}
