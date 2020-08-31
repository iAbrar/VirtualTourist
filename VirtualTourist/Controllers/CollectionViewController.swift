//
//  CollectionViewController.swift
//  VirtualTourist
//
//  Created by imac on 8/23/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit
import Kingfisher
import MapKit


private let reuseIdentifier = "customCell"

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imagesUrl = [String]()
    var pin : MKAnnotation?
    var page = 1
    
    @IBOutlet var collection: UICollectionView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        mapView.addAnnotation(pin!)
        mapView.showAnnotations([pin!], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        guard  let lat = pin?.coordinate.latitude else { return }
        guard  let lon = pin?.coordinate.longitude else { return }

        page = 1
        
        FlickrAPI.downloadJSON(longitude: lon, latitude: lat, page: page)
        { images, error in
            
            
            if error == nil
            {
                DispatchQueue.main.async {
                    self.imagesUrl = images
                    self.collection.reloadData()
                    
                }
                
            }
            
        }
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imagesUrl.count
        
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        //        cell.imageView.image = UIImage(named: "y9DpT")
        let url = URL(string: imagesUrl[indexPath.row])
        
        let image = UIImage(named: "y9DpT")
        cell.imageView.kf.setImage(with: url, placeholder: image)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = self.imagesUrl.remove(at:indexPath.row)
        self.collection.deleteItems(at: [indexPath])
        print("delete")
        
    }
    
    @IBAction func newCollectionTapped(_ sender: UIButton) {
        
        page = page+1
        print(page)
        
        FlickrAPI.downloadJSON(longitude: pin!.coordinate.longitude, latitude: pin!.coordinate.latitude, page: page)
            { images, error in
                
                
                if error == nil
                {
                    DispatchQueue.main.async {
                        self.imagesUrl = images
                        self.collection.reloadData()
                        
                    }
                    
                }
                
        }
    }
    
}
