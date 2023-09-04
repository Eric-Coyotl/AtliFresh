//
//  Location.swift
//  Atli
//
//  Created by Eric Coyotl on 7/28/23.
//

import Foundation
import MapKit


// Equatable: for two or more same locations, should they be considered equal?

struct Location: Identifiable, Equatable {
    
    // location will be set up like a google/yelp review
    
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    // Identifiable
    var id: String {
        // name: collosseum,
        // cityname:  = rome
        
        name + cityName
    }
        
    // Equatable
    static func == (lhs: Location, rhs: Location) ->  Bool {
        lhs.id == rhs.id
    }
}


