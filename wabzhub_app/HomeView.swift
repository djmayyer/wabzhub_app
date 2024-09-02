//
//  HomeView.swift
//  wabzhub_app
//
//  Created by Horia Zamfir on 26.08.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var isSignUp: Bool = false
    @State private var selectedLanguage: String = "EN" // Default language

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("WABZ")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .accessibilityLabel("WABZ")
                        .accessibilityAddTraits(.isHeader)
                    
                    Spacer()
                    
                    Menu {
                        Button(action: { selectedLanguage = "EN" }) {
                            Text("English")
                        }
                        Button(action: { selectedLanguage = "ES" }) {
                            Text("Spanish")
                        }
                        Button(action: { selectedLanguage = "FR" }) {
                            Text("French")
                        }
                        Button(action: { selectedLanguage = "DE" }) {
                            Text("German")
                        }
                    } label: {
                        Text(selectedLanguage)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(Circle().fill(Color.orange))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20)
                }
                .padding(.horizontal)
                .background(Color.white)
                
                Spacer()
                
                Image("LogoWabz")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240, height: 180)
                    .padding(.bottom, 150)
                    .padding(.top, 40)
                
                Text("Welcome")
                    .font(.largeTitle)
                    .padding(.bottom, 5)
                    .accessibilityLabel("Welcome to the WABZ app")
                
                Text("to the future of business cards")
                    .padding(.bottom, 20)
                    .accessibilityLabel("Explore the future of business cards")
                
                Button(action: {
                    isSignUp = true
                }) {
                    HStack {
                        Text("Create account")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 240, height: 50)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.yellow]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .accessibilityLabel("Create an account")
                .accessibilityHint("Tap to sign up for a new account")
                .navigationDestination(isPresented: $isSignUp) {
                    SignUp()
                }
                .padding(.bottom, 20)
                
                NavigationLink(destination: ContentView()) {
                    Text("Already have an account? Sign In")
                        .foregroundColor(.orange)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .accessibilityLabel("Sign In")
                .accessibilityHint("Tap to sign in to your account")
                
                Spacer()
            }
            .background(Color.white)
            .preferredColorScheme(.light)
        }
    }
}

// View Extensions
extension View {
    func pressAction(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
        self.simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in onPress() }
                .onEnded { _ in onRelease() }
        )
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
