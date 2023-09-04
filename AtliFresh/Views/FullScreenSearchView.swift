//
//  FullScreenSearchView.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 8/30/23.
//

import SwiftUI

struct FullScreenSearchView: View {
    enum FocusField: Hashable {
        case field
    }
    @FocusState private var focusedField: FocusField?
    
    @EnvironmentObject private var vm: LocationsViewModel

    @Binding var searchString: String
    let accentColor = Color("AccentColor")
    
    var body: some View {
        
        ZStack {
            Color.white.ignoresSafeArea()
            VStack() {
                SearchBar
                List{
                    ForEach(filteredLocations){ location in
                        Text(location.name)
                    }
                }
                .listStyle(.grouped)
                 
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct FullScreenSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenSearchView(searchString: .constant(""))
            .environmentObject(LocationsViewModel())
    }
}

extension FullScreenSearchView{
    
    private var SearchBar: some View {
        HStack() {
            Button {
                vm.showSearchView = false
                focusedField = nil
                vm.hideStatusBar = false
                searchString = ""
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(accentColor)
                    .font(.title2)
                    .frame(alignment: .leading)
                    .padding(.leading)
            }

            
            
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
                .focused($focusedField, equals: .field)
                          .onAppear {
                            self.focusedField = .field
                        }
        }
        .padding(.vertical, 10)
        .frame(maxWidth: 360)
        .background(.thickMaterial)
        .cornerRadius(100)
        .shadow(color: Color.black.opacity(0.5), radius: 0.5)
    }
    
    private var filteredLocations: [Location]{
        if (vm.debouncedSearchString == ""){
            return vm.locations
        }else{
            let lowercasedText = vm.debouncedSearchString.lowercased()
            return vm.locations.filter { location in
                location.name.lowercased().contains(lowercasedText) ||
                location.description.lowercased().contains(lowercasedText)
            }
        }
        
    }
}
