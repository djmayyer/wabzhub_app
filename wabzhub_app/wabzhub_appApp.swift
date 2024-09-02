//
//  wabzhub_appApp.swift
//  wabzhub_app
//
//  Created by Horia Zamfir on 26.08.2024.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct wabzhub_appApp: App {
    // register app delegate for Firebase setup
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
