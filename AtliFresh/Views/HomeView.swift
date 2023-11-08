//
//  HomeView.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 10/1/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var avm: AuthViewModel
        
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                HStack (spacing: 25){
                    NavigationLink {
                        SignInView()
                    } label: {
                        signInLabel
                    }
                    NavigationLink {
                        SignUpView()
                    } label: {
                        signUpLabel
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
    }
}

extension HomeView {
    
    private var signInLabel: some View {
        Text("Log In")
            .padding()
            .frame(width: 150)
            .background(Color("BackColor"))
            .foregroundColor(Color(UIColor.systemBrown))
            .font(.title2)
            .fontWeight(.semibold)
            .cornerRadius(100)
    }

    private var signUpLabel: some View {
        Text("Sign Up")
            .padding()
            .frame(width: 150)
            .background(Color("AccentColor"))
            .foregroundColor(Color(UIColor.systemBackground))
            .font(.title2)
            .fontWeight(.semibold)
            .cornerRadius(100)
    }
    

}
