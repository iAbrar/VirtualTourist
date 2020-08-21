//
//  APIManager.swift
//  VirtualTourist
//
//  Created by imac on 8/19/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import Foundation

struct APImanager{
    let flickrURL = "https://api.flickr.com/services/rest?api_key=8d927e7b549ee5c8661eb815006bcbf3&method=flickr.photos.search&format=json&per_page=10&extras=url_m&nojsoncallback=1&accuracy=11"
    
    func fetchImages(longitude: String, latitude: String, page: Int)
    {
        let url = "\(flickrURL)&lon=\(longitude)&lat=\(latitude)&page=\(page)"
        performApiRequest(url: url)
    }
    
    func performApiRequest(url: String){
        // create url
        if let url = URL(string: url){
            //create urlSession
            let session = URLSession(configuration: .default)
            
            // give a session task
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    print(error!)
                }
                if let dataObject = data {
                    self.parseJSON(data: dataObject)
                }
                else{
                    print("can not get data")
                }
            }
            //start task
            task.resume()
        }
    }
    func parseJSON(data: Data){
        
        let decoder = JSONDecoder()
        do{
           let decodedData = try decoder.decode(FlickrData.self, from: data)
            
        let photos = decodedData.photos.photo
           
            for photo in photos{
                print(photo.url_m)
            }
            
        } catch {
            print("error")
        }
    }
}
