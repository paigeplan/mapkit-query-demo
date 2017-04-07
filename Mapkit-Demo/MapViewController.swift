//
//  MapViewController.swift
//  Mapkit-Demo
//
//  Created by Paige Plander on 4/7/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let berkeleyCoordinate =  CLLocationCoordinate2D(latitude: 37.8719, longitude: -122.2585)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegion(center: berkeleyCoordinate, span: span)
        mapview.setRegion(region, animated: true)
        
        // Make a request for locations in the region that are of type "emergency"
        // You'll probably want to play around with different query strings 
        // to get exactly what you want for each category
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "emergency"
        request.region = mapview.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print(String(describing: error))
                return
            }
            for item in response.mapItems {
                // You can use the item to get the location's name, phone number, website, and location
                let locationName: String = String(describing: item.name)
                let locationPhoneNumber: String = String(describing: item.phoneNumber)
                print("\(locationName) \(locationPhoneNumber)")
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                self.mapview.addAnnotation(annotation)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

