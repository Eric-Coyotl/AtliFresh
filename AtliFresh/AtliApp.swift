//
//  AtliApp.swift
//  Atli
//
//  Created by Eric Coyotl on 7/26/23.
//

import SwiftUI
import Firebase

@main
struct AtliApp: App {
        
    init() {
        FirebaseApp.configure()
        print("Configured Firebase!")
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(AuthViewModel())
                .environmentObject(LocationsViewModel())
        }
    }
}
