//
//  LocationsView.swift
//  Atli
//
//  Created by Eric Coyotl on 7/28/23.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
          mapLayer
            .ignoresSafeArea()
            // vertical stack
            
            VStack {
                SearchBarView(searchString: $vm.searchString)
                    
                Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
            
            VStack(spacing: 0){
                //header
                
                Spacer()
                if(!vm.showSearchView){
                    footer
                }
                //locationsPreviewStack
            }
            .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in LocationDetailView(location: location)
            }
            .ignoresSafeArea(.keyboard)
            /*
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                if(vm.showShowListPreview){
                    footer
                }
            }
            */
        }
        .statusBarHidden(vm.hideStatusBar)
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}


extension LocationsView {
    
    private var header: some View {
        VStack{
            Button(action: vm.toggleLocationsList ){
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                                .font(.title2)
                                .fontWeight(.black)
                                .foregroundColor(.primary)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .animation(.none, value: vm.mapLocation)
                                .overlay(alignment: .leading){
                                    Image(systemName: "arrow.down")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .padding()
                                        .rotationEffect(Angle(degrees:
                                                    vm.showLocationsList ? -180: 0 ))
                                }
                
            }
            if vm.showLocationsList{
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 15 )
    }
    
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates){
                    LocationMapAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                        }
                }
            }
        )
    }
    
    private var locationsPreviewStack: some View {
        VStack(){
            ForEach(vm.locations) { location in
                
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 20)
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
    
    private var footer: some View{
        Button{
            vm.sheetLocationDetails = true
        } label: {
            Text("SHOW LIST")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundColor(Color.blue)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color(UIColor.systemBackground))
        .shadow(radius: 4)
        .transition(.move(edge: .bottom))
        
        .sheet(isPresented: $vm.sheetLocationDetails){
            LocationsInfoView()
                .presentationDetents([.medium, .large])
        }
        .ignoresSafeArea()
    }
    
}
