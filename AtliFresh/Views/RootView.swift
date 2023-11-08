//
//  RootView.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 10/3/23.
//


import SwiftUI


struct RootView: View {
    @State private var showMenu = false
    @EnvironmentObject var avm: AuthViewModel
    @EnvironmentObject var lvm: LocationsViewModel
    
    var body: some View {
        Group{
            if avm.userSession == nil {
                HomeView()
            }else{
                LocationsView()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AuthViewModel())
        .environmentObject(LocationsViewModel())
}
