//
//  AtliApp.swift
//  Atli
//
//  Created by Eric Coyotl on 7/26/23.
//

import SwiftUI

@main
struct AtliApp: App {

    @StateObject private var vm = LocationsViewModel()

    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
