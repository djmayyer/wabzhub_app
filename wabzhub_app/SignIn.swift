import SwiftUI
import Firebase
import FirebaseAuth

struct SignIn: View {
    @State private var signInErrorMessage: String = "Username or Password is incorrect"
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
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
                
                // EMAIL INPUT
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
                
                // PASSWORD INPUT
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
                    Text("\(signInErrorMessage)")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Button(action: {
                    signInUser(email: email, password: password)
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
                
                Text("By signing in, you agree to our Terms of Service and Privacy Policy")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 10)
                
                NavigationLink(destination: SignUp()){
                    Text("Don't have an account? **Sign Up**")
                        .foregroundColor(.orange)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.light)
    }

    func signInUser(email: String, password: String) {
        print("Attempting to sign in with email: \(email) and password: \(password)")
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                signInErrorMessage = "Failed to sign in: \(error.localizedDescription)"
                showError()
            } else {
                print("Sign in successful")
                isLoggedIn = true
            }
        }
    }


    func showError() {
        isErrorVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            isErrorVisible = false
        }
    }
}

struct SignIn_Preview: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
