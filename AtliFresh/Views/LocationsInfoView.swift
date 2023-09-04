//
//  LocationsInfoView.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 8/18/23.
//

import SwiftUI

struct LocationsInfoView: View {

    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        ScrollView{
            ForEach(vm.locations){ location in
                LocationPreviewView(location: location)
            }
            .padding(0)
            .background(.ultraThinMaterial)
        }
        .listStyle(.plain)
    }
}

struct LocationsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            LocationsInfoView()
                .environmentObject(LocationsViewModel())
        }
    }
}
