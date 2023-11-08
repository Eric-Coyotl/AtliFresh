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
    @State private var searchString = ""
    
    let accentColor = Color("AccentColor")
    
    var body: some View {
        
        ZStack {
            Color(UIColor.systemBackground).ignoresSafeArea()
            VStack() {
                SearchBar
                    .padding()
                                
                List{
                    ForEach(filteredLocations){ location in
                        Button {
                            vm.showSearchView = false
                            focusedField = nil
                            vm.hideStatusBar = false
                            searchString = ""
                            vm.showNextLocation(location: location)
                        } label: {
                            Text(location.name)
                                .foregroundColor(.primary)
                        }
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
        FullScreenSearchView()
            .environmentObject(LocationsViewModel())
    }
}

extension FullScreenSearchView{
    
    private var SearchBar: some View {
        HStack() {
            Button {
                withAnimation(.easeOut(duration: 0.1)){
                    vm.showSearchView = false
                }
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
                .padding(.leading, 14.5)
                .overlay(alignment: .trailing){
                    ZStack {
                        Image(systemName: "multiply.circle")
                            .resizable()
                            .fontWeight(.medium)
                            .fontWidth(.compressed)
                            .frame(width: 20, height: 20)
                            .padding(.horizontal)
                        Rectangle().frame(width: 50,
                                          height: 50).opacity(0.001)
                                            .layoutPriority(-1)
                    }
                    .opacity(searchString.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
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
