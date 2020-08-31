//
//  ViewController.swift
//  VirtualTourist
//
//  Created by imac on 8/18/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {


    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          mapView.delegate = self

    }

    @IBAction func addPinTapped(_ sender: UILongPressGestureRecognizer) {
        
        let location = sender.location(in: mapView)
        let locationCoordinator = mapView.convert(location, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()

        annotation.coordinate = CLLocationCoordinate2D(latitude: locationCoordinator.latitude, longitude: locationCoordinator.longitude)
        mapView.addAnnotation(annotation)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pin = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: pin) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pin)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        mapView.deselectAnnotation(view.annotation! , animated: true)
        let pin = view.annotation!
        

        let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController;
        
        vc.pin = pin
      
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

