//
//  DataController.swift
//  VirtualTourist
//
//  Created by imac on 8/31/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import Foundation
import CoreData

class DataController{
    
    let presistentContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext{
        return presistentContainer.viewContext
    }
    
    init(modelName:String) {
        presistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion:(() -> Void)? = nil){
        presistentContainer.loadPersistentStores{ storeDescription, error in
            guard error == nil else{
                fatalError(error!.localizedDescription)
            }
            completion?()
            
        }
    }
    
}
