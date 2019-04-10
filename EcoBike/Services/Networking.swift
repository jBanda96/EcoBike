//
//  Networking.swift
//  EcoBike
//
//  Created by Julio Banda on 4/9/19.
//  Copyright © 2019 julio.banda. All rights reserved.
//

import Foundation

struct Networking {
    
    typealias Info = (Result) -> Void
    
    enum Result {
        case success([Station])
        case error(String)
    }
    
    private init() {}
    
    static func downloadStationInfo(completionHandler: Info) {
        let bundle  =   Bundle.main
        let path    =   bundle.path(forResource: "AvailabilityPerStation", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
            
            let stations = try JSONDecoder().decode([Station].self, from: data)
            completionHandler(.success(stations))
            
            
        } catch {
            completionHandler(.error(error.localizedDescription))
        }
        
    }
    
}
