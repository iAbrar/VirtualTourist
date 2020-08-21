//
//  ViewController.swift
//  VirtualTourist
//
//  Created by imac on 8/18/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var apiManager = APImanager()
    var page = 1
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lat = "24.7136"
        let lon = "46.6753"
        
        apiManager.fetchImages(longitude: lon, latitude: lat, page: page)
    }


}

