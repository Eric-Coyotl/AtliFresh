//
//  SearchBarView.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 8/30/23.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject private var vm: LocationsViewModel

    let accentColor = Color("AccentColor")
    
    var body: some View {
        
        if (vm.showSearchView){
            FullScreenSearchView()
        }
        else{
            SearchBar
                .padding()
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.1)) {
                        vm.showSearchView = true
                    }
                    vm.hideStatusBar = true
                }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {            
            SearchBarView()
                .environmentObject(LocationsViewModel())
        }
    }
}


extension SearchBarView{
    private var SearchBar: some View {
        HStack() {
            Image(systemName: "mappin.and.ellipse")
                .foregroundColor(accentColor)
                .font(.title2)
                .frame(alignment: .leading)
                .padding(.leading)
            
            Text("Search here")
                .font(.title3)
                .foregroundStyle(Color(.gray)
                    .opacity(0.6))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 6)
                .offset(y: -1.5)
            Button{
                withAnimation(.easeIn(duration: 0.1)) {
                    vm.showSettingsView.toggle()
                }
            } label: {
                ZStack {
                    Image(systemName: "gearshape")
                        .padding(.horizontal)
                    Rectangle().frame(width: 50, 
                                      height: 50).opacity(0.001)
                                        .layoutPriority(-1)
                }
            }
        }
        .padding(.vertical, 10)
        .frame(maxWidth: 360)
        .background(.thickMaterial)
        .cornerRadius(100)
        .shadow(color: Color.black.opacity(0.2), radius: 5, y: 5 )
    }
}
