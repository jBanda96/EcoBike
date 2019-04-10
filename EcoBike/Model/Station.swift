//
//  Station.swift
//  EcoBike
//
//  Created by Julio Banda on 4/8/19.
//  Copyright © 2019 julio.banda. All rights reserved.
//

import Foundation
import MapKit

class Station: Decodable {
    
    let id:                 String
    let district:           String
    let lon:                String
    let lat:                String
    let bikes:              String
    let slots:              String
    let zip:                String?
    let address:            String
    let addressNumber:      String
    let nearbyStations:     String
    let status:             String
    let name:               String
    let stationType:        String
    
    var distanceFromUserLocation: CLLocationDistance?
    
    init(id: String,
         district: String,
         lon: String,
         lat: String,
         bikes: String,
         slots: String,
         zip: String,
         address: String,
         addressNumber: String,
         nearbyStations: String,
         status: String,
         name: String,
         stationType: String) {
        
        self.id = id
        self.district = district
        self.lon = lon
        self.lat = lat
        self.bikes = bikes
        self.slots = slots
        self.zip = zip
        self.address = address
        self.addressNumber = addressNumber
        self.nearbyStations = nearbyStations
        self.status = status
        self.name = name
        self.stationType = stationType
        
    }
    
    func createLocation() -> CLLocation {
        return CLLocation(latitude: Double(lat) ?? 0, longitude: Double(lon) ?? 0)
    }
    
    func distance(to location: CLLocation) {
        let myLocation = createLocation()
        
        let distance = myLocation.distance(from: location)
        distanceFromUserLocation = distance
    }
    
}
