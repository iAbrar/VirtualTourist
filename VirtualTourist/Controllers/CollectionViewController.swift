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
    
    @IBOutlet var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(pin?.coordinate.latitude)
        guard  let lat = pin?.coordinate.latitude else { return }
        guard  let lon = pin?.coordinate.longitude else { return }
        
        
        FlickrAPI.downloadJSON(longitude: lon, latitude: lat, page: 1)
        { images, error in
            
            
            if error == nil
            {
                DispatchQueue.main.async {
                    self.imagesUrl = images
                    self.collection.reloadData()
                    
                }
                
            }
            
            print("willwill",self.imagesUrl.count)
            
        }
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
    

    
}
