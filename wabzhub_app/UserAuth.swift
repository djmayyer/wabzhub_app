//
//  UserAuth.swift
//  wabzhub_app
//
//  Created by Horia Zamfir on 30.08.2024.
//

import SwiftUI
import Firebase
import Combine
import FirebaseAuth

class UserAuth: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?
    
//    init() {
//        // Listen for authentication state changes
//        Auth.auth().addStateDidChangeListener { _, user in
//            self.isLoggedIn = (user != nil)
//        }
//    }
//    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = "Failed to sign in: \(error.localizedDescription)"
            } else {
                self.isLoggedIn = true
            }
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.isLoggedIn = false
    }
}
