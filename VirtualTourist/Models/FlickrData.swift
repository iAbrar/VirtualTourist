//
//  flickrData.swift
//  VirtualTourist
//
//  Created by imac on 8/20/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import Foundation

struct FlickrData: Decodable{
    let stat: String
    let photos: Photos
}

struct Photos: Decodable {
    let page: Int
    let total: String
    let photo: [Photo]
}

struct Photo: Decodable {
    let id: String
    let url_m: String
}
