//
//  SettingsView.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 10/4/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    @EnvironmentObject private var avm: AuthViewModel
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Button{
                withAnimation {
                    vm.showSettingsView.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .padding()
            }
            Divider()
            
            HStack{
                Image(systemName: "square.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundColor(.blue)
                    .padding(.vertical)
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text("User Name")
                    
                    Text("email@email.com")
                        .font(.subheadline)
                }
                .padding(.leading, 10)
            }
            Divider()
            
            Button {
                avm.signOut()
                vm.showSettingsView.toggle()
            } label: {
                HStack{
                    Image(systemName:
                            "rectangle.portrait.and.arrow.right")
                    .rotationEffect(.degrees(180))
                    .padding(.vertical)
                    .padding(.leading)
                    .padding(.trailing, 5)
                    
                    Text("Logout")
                }
            }
        Spacer()
        }
        .background(.thickMaterial)
        .frame(maxWidth: 330, maxHeight: 550)
        .cornerRadius(10)
    }
}

#Preview {
    SettingsView()
        .environmentObject(LocationsViewModel())
        .environmentObject(AuthViewModel())
}
