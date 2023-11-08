//
//  AuthenticationManager.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 10/1/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift

enum AuthProviderOption: String{
    case email = "password"
    case google = "google.com"
}

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?

    init() {
        self.userSession = Auth.auth().currentUser
        
        print("DEBUG: User session is \(String(describing: self.userSession))")
        print(self.userSession == nil)
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    // google.com
    // password
    
    
    func getProvider() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        var providers: [AuthProviderOption] = []
        for provider in providerData{
            if let option = AuthProviderOption(rawValue: provider.providerID){
                providers.append(option)
            }else{
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        return providers
    }
    
    //MARK: - Login with Credential (used for Apple & Google Login
    func loginCredential(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            
            let data = ["email": user.email,
                        "username": user.displayName,
                        "uid": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data as [String : Any]) { _ in
                    print("DEBUG: Did upload user data")
                }
        }
    }
    
    
    //MARK: - Login with Email
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            
        }
        
    }
    
    
    //MARK: - Login w/ Gmail
    func signInGoogle() async throws {
        guard let topVC = UIApplication.shared.topViewController() else{
            throw URLError(.cannotFindHost)
        }

        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        //GIDSignInResult.user
        
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
    
        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        let credential =  GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: accessToken)
        
        return loginCredential(credential: credential)
    }
    
    //MARK: - Register
    func register(withEmail email: String, password: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("DEBUG: Registered user successfully!")
            print("DEBUG: User is \(String(describing: self.userSession))")
            
            let data = ["email": email,
                        "username": username.lowercased(),
                        "uid": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    print("DEBUG: Did upload user data")
                }
        }
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
}
