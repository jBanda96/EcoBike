//
//  BikesTableViewModel.swift
//  EcoBike
//
//  Created by Julio Banda on 4/8/19.
//  Copyright © 2019 julio.banda. All rights reserved.
//

import Foundation
import MapKit

struct BikesTableViewModel {
    
    fileprivate let station: Station
    
    init(station: Station) {
        self.station = station
    }
    
    var address: String {
        let splittedAddress = station.address.split(separator: "-")
        let droppedFirst = splittedAddress.dropFirst()
        
        return droppedFirst.joined(separator: "-")
    }

    var slots: String {
        return "Slots: \(station.slots)"
    }

    var bikes: String {
        return "Bikes: \(station.bikes)"
    }
    
    var slotsNumber: String {
        return station.slots
    }
    
    var bikesNumber: String {
        return station.bikes
    }
    
    var location: String {
        return "Lat: \(station.lat) - Lon: \(station.lon)"
    }
    
    var latitude: Double {
        return Double(station.lat) ?? 0.0
    }
    
    var longuitude: Double {
        return Double(station.lon) ?? 0.0
    }
    
    var nearStations: String {
        let count = station.nearbyStations.count
        let text = count > 1 ? "estaciones cercanas" : "estación cercana"
        
        return "\(count) \(text)"
    }
    
    var mainStationAnnotation: CustomAnnotation {
        let annotation = CustomAnnotation(title: address, coordinate: CLLocationCoordinate2DMake(latitude, longuitude))
        return annotation
    }
    
    var region: MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        return MKCoordinateRegion(center: mainStationAnnotation.coordinate, span: span)
    }
    
}

class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
}
