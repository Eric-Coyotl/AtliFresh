//
//  SignInView.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 9/28/23.
//

import SwiftUI
import GoogleSignInSwift

struct SignInView: View {
    @EnvironmentObject private var avm: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var email = ""
    @State private var password = ""
    
    let accentColor = Color("AccentColor")

    var body: some View {
        VStack {
            Text("Log in")
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
                    .textInputAutocapitalization(.never)
                
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

            forgotPassword
            logInButton
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


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(AuthViewModel())
    }
}

extension SignInView {
    
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
    
    private var logInButton: some View {
        Button{
            avm.login(withEmail: email, password: password)
        } label: {
            Text("Log In")
        }
        .buttonStyle(ThemeButton(
            backColor: Color("AccentColor"),
            textColor: Color(UIColor.systemBackground),
            buttonWidth: 360
        ))
    }
    private var forgotPassword: some View {
        Button {
            
        } label: {
            Text("Forgot Password?")
                .frame(maxWidth: 360 , alignment: .leading)
                .foregroundColor(Color.blue)
                .font(.subheadline)
                .padding(.bottom)
        }
    }
}
