//
//  StationDetailViewController.swift
//  EcoBike
//
//  Created by Julio Banda on 4/9/19.
//  Copyright © 2019 julio.banda. All rights reserved.
//

import UIKit
import MapKit

class StationDetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var viewModel: BikesTableViewModel? {
        didSet {
            print(viewModel!.location)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map.showsUserLocation = true
        self.map.addAnnotation(viewModel!.mainStationAnnotation)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.map.setRegion(viewModel!.region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        if annotation is CustomAnnotation {
            let annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
            annotationView.image = #imageLiteral(resourceName: "estacion")
            annotationView.viewModel = viewModel
            return annotationView
        }
        
        return nil
        
    }
    
    @IBAction func changeMapType(_ button: UISegmentedControl) {
        self.map.mapType = MKMapType.init(rawValue: UInt(button.selectedSegmentIndex)) ?? .standard
    }

}
