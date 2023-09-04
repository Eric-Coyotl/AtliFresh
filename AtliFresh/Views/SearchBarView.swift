//
//  SearchBarView.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 8/30/23.
//

import SwiftUI

struct SearchBarView: View {
    
    @State private var showingSheet = false

    @EnvironmentObject private var vm: LocationsViewModel

    @Binding var searchString: String
    let accentColor = Color("AccentColor")
    
    var body: some View {
        
        if (vm.showSearchView){
            FullScreenSearchView(searchString: $vm.searchString)
        }
        else{
            SearchBar
                .onTapGesture {
                    vm.showSearchView = true
                    vm.hideStatusBar = true
                }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {            
            SearchBarView(searchString: .constant(""))
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
            
            TextField("Search here", text: $searchString)
                .font(.title3)
                .fontWeight(.regular)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 6)
                .overlay(alignment: .trailing){
                    Image(systemName: "x.circle")
                        .padding(.horizontal, 16)
                        .opacity(searchString.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchString = ""
                            
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
