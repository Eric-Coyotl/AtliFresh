//
//  LocationPreviewView.swift
//  Atli
//
//  Created by Eric Coyotl on 8/2/23.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    let accentColor = Color("AccentColor")

    let location: Location
    
    var body: some View {
        VStack(alignment: .center,  spacing: 1.0) {
            VStack(alignment: .leading, spacing: 6.0) {
                imageSection
                titleSection
            }
            .padding(.bottom, 10)
            HStack(spacing: 16.0){
                learnMoreButton
                nextButton
            }
        }
        .padding(16)
        .background(
            Color(UIColor.systemBackground)
        )
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
        }
        .environmentObject(LocationsViewModel())
    }
}


extension LocationPreviewView {
    
    
    private var imageSection: some View {
        ZStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 2) {
                    ForEach(location.imageNames, id: \.self){
                        Image($0)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        Spacer()
                    }
                }
                .padding(0)
            }
        }
        .padding(6)
        .background(Color.clear)
        .cornerRadius(10)
        .edgesIgnoringSafeArea(.all)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(location.name)
                .fontWeight(.semibold)
                .lineLimit(2)
                .truncationMode(.tail)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(2)
    }
    
    private var learnMoreButton: some View {
        Button {
            // Environment location is set equal to location of preview view
            vm.sheetLocationDetails = false
            vm.sheetLocation = location
            
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125, height: 35)
                
        }
        .buttonStyle(.borderedProminent)
        .tint(accentColor)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPress()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
                .foregroundStyle(accentColor)
        }
        .buttonStyle(.bordered)
    }
}
