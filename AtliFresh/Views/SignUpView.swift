//
//  SignUpView.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 10/1/23.
//
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignUpView: View {
    @EnvironmentObject private var avm: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
        
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            Text("Email")
                .padding(.bottom, 0.1)
            Divider()
                .frame(width: 100, height: 2)
                .overlay(.black)
            
            Group{
                TextField("Email", text: $email)
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }
            .padding(.top, 12)
            .padding(.bottom, 12)
            .padding(.leading, 10)
            .frame(maxWidth: 360)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray))
            .padding(.bottom, 5)
            
            signUpButton
            labelDivider(label: "or",
                         horizontalPadding: 3,
                         color: Color.black)
            .padding(.top, 10)
            .padding(.horizontal)
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)){
                Task{
                    do {
                        try await avm.signInGoogle()
                    } catch{
                        print(error)
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthViewModel())
    }
}

extension SignUpView{
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
                .fontWeight(.bold)
        }
    }
    private var signUpButton: some View {
        Button {
            avm.register(withEmail: email, password: password, username: username)
        } label: {
            Text("Sign Up")
        }
        .buttonStyle(ThemeButton(
            backColor: Color("AccentColor"),
            textColor: Color(UIColor.systemBackground),
            buttonWidth: 360
        ))
    }
    
    private var continueText: some View {
        Button {
            
        } label: {
            Text("Skip for now")
                .fontWeight(.heavy)
                .foregroundColor(Color("accentColor"))
        }
    }
}
