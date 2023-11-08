//
//  LocationsViewModel.swift
//  Atli
//
//  Created by Eric Coyotl on 7/31/23.
//

import Foundation
import MapKit
import SwiftUI
import Combine

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    
    let mapSpan =  MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // show list of locations
    @Published var showLocationsList: Bool = false
    
    // Show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    // show ShowList preview
    @Published var showShowListPreview: Bool = true
    
    @Published var sheetLocationDetails: Bool = false
    
    // search function variables
    @Published var searchString: String = ""
    @Published var showSearchView: Bool = false
    @Published var hideStatusBar: Bool = false
    @Published var debouncedSearchString: String = ""
    
    // Settings View
    @Published var showSettingsView: Bool = false
    
    // Camera variables
    @Published var selectedImage: UIImage? = nil
    
    @Published var didSelectImage: Bool = false
    @Published var showUploadView: Bool = false
    
    // show imagepicker is for initial camera
    @Published var showImagePicker: Bool = false
    // for inner camera screen
    @Published var showCameraView: Bool = false


    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
        setupStringDebounce()
    }
        
    func setupStringDebounce() {
        debouncedSearchString = self.searchString
        $searchString
            .debounce(for: .seconds(0.2), scheduler: RunLoop.main)
            .assign(to: &$debouncedSearchString)
    }
    
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    public func toggleLocationsList(){
        withAnimation(.easeInOut){
            showLocationsList = !showLocationsList
        }
    }
    
    public func showNextLocation(location: Location){
        withAnimation(.easeInOut){
            mapLocation = location
            //showLocationsList = true
        }
    }
    
    public func toggleShowListPreview(){
        withAnimation(.easeInOut){
            showShowListPreview = !showShowListPreview
        }
    }
    
    public func trueShowListPreview(){
        withAnimation(.easeInOut){
            showShowListPreview = true
        }
    }
    
    public func nextButtonPress(){
        // get current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current index in locations array! Should never happen")
            return
        }
        // Check if current index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is NOT valid
            // Restart from 0
            
            guard let firstLocation = locations.first else{return}
            showNextLocation(location: firstLocation)
            return
        }
        
        // nextIndex IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
    public func getLocationURL(coordinate: CLLocationCoordinate2D) -> URL {
        let urlLatitude = coordinate.latitude
        let urlLongitude = coordinate.longitude
        
        let url = URL(string: "maps://?saddr=&daddr=\(urlLatitude),\(urlLongitude)")!
        
        return url
    }
}
