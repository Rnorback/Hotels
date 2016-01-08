//
//  HotelMapVC.swift
//  Hotels
//
//  Created by Rob Norback on 1/6/16.
//  Copyright © 2016 Rob Norback. All rights reserved.
//

import UIKit
import MapKit

class HotelMapVC: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var hotelData:Hotel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerMapOnLocation(hotelData.location)
        
        // Drop a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = hotelData.location.coordinate
        dropPin.title = hotelData.name
        mapView.addAnnotation(dropPin)
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        // Shows a 2000m by 2000m view on the map
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
