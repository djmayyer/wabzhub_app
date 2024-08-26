//
//  HomeView.swift
//  wabzhub_app
//
//  Created by Horia Zamfir on 26.08.2024.
//


import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            Text("You are now logged in.")
                .font(.title)
                .padding(.bottom, 40)
            
//            NavigationLink(destination: SettingsView()) {
//                Text("Go to Settings")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(width: 220, height: 60)
//                    .background(Color.green)
//                    .cornerRadius(15.0)
//            }
        }
        .navigationTitle("Home")
        .padding()
    }
}
