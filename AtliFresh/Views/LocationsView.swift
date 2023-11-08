//
//  LocationsView.swift
//  Atli
//
//  Created by Eric Coyotl on 7/28/23.
//

import SwiftUI
import MapKit
import UIKit
import Mantis

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700
    let creamColor = Color("BackColor")
    

    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack {
                SearchBarView()
                Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
            
            if (!vm.showSearchView){
                VStack(spacing: 0){
                    Spacer()
                    HStack{
                        Spacer()
                        cameraButton
                            .padding()
                    }
                    footer
                }
                .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in LocationDetailView(location: location)
                    }
                    .ignoresSafeArea(.keyboard)
            }
            Group{
                if (vm.showSettingsView){
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            vm.showSettingsView.toggle()
                        }
                }
                if (vm.showSettingsView) {
                    SettingsView()
                        .transition(.scale(scale: 0.001, anchor: .topTrailing).combined(
                            with: AnyTransition.offset(x: 0, y: -80)))
                }
            }
            
            Group{
                ZStack{
                    if(vm.showImagePicker){
                        ImagePicker(selectedImage: $vm.selectedImage, didSelectImage: $vm.didSelectImage)
                            .ignoresSafeArea(.all)
                    }
                    if(vm.showUploadView){
                        ImageUploadView(cropImage: $vm.selectedImage)
                            .ignoresSafeArea(.all)
                    }
                }
            }
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
        .ignoresSafeArea()
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
    
    private var cameraButton: some View {
        Button{
            vm.showImagePicker = true
        } label: {
            ZStack{
                Circle()
                    .frame(width: 70)
                    
                Image(systemName: "plus.viewfinder")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.systemBackground))
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
