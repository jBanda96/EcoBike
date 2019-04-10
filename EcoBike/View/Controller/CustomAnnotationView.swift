//
//  CustomAnnotationView.swift
//  EcoBike
//
//  Created by Julio Banda on 4/9/19.
//  Copyright © 2019 julio.banda. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotationView: MKAnnotationView {

    weak var customCalloutView: StationDetailMapView?
    
    var viewModel: BikesTableViewModel?
    
    override var annotation: MKAnnotation? {
        willSet { customCalloutView?.removeFromSuperview() }
    }
    
    // MARK: - lifecycle
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.customCalloutView?.removeFromSuperview()
            
            if let newCustomCalloutView = loadStationDetailMapView() {
                
                newCustomCalloutView.viewModel = viewModel
                newCustomCalloutView.frame.origin.x -= newCustomCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
                newCustomCalloutView.frame.origin.y -= newCustomCalloutView.frame.height + 10
                
                self.addSubview(newCustomCalloutView)
                self.customCalloutView = newCustomCalloutView
                
                if animated {
                    self.customCalloutView!.alpha = 0.0
                    UIView.animate(withDuration: 0.3, animations: {
                        self.customCalloutView!.alpha = 1.0
                    })
                }
            }
        } else {
            if customCalloutView != nil {
                if animated {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.customCalloutView!.alpha = 0.0
                    }, completion: { (success) in
                        self.customCalloutView!.removeFromSuperview()
                    })
                } else { self.customCalloutView!.removeFromSuperview() }
            }
        }
    }
    
    func loadStationDetailMapView() -> StationDetailMapView? {
        
        if let views = Bundle.main.loadNibNamed("CustomAnnotationView", owner: self, options: nil) as? [StationDetailMapView], views.count > 0 {
            let personDetailMapView = views.first!
            return personDetailMapView
        }
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.customCalloutView?.removeFromSuperview()
    }

}

class StationDetailMapView: UIView {
    
    @IBOutlet weak var bikes: UILabel!
    @IBOutlet weak var slots: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var nearStations: UILabel!
    
    var viewModel: BikesTableViewModel? {
        didSet {
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 50.0
        
        self.backgroundColor = UIColor.init(displayP3Red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1)
        
    }
    
    func configureView(){
        bikes.text = viewModel?.bikesNumber
        slots.text = viewModel?.slotsNumber
        
        address.text = viewModel?.address
        
        nearStations.text = viewModel?.nearStations
    }
    
}
