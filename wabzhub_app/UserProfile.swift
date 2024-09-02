//
//  UserProfile.swift
//  wabzhub_app
//
//  Created by Horia Zamfir on 27.08.2024.
//
import SwiftUI

struct UserProfile: View {
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            Text("User Profile")
                .font(.title)
                .padding(.bottom, 40)
        }
        .navigationBarBackButtonHidden(true)
    }
}
