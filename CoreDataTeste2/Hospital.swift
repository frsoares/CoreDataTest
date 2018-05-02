//
//  Hospital.swift
//  CoreDataTeste2
//
//  Created by Francisco Soares on 26/04/18.
//  Copyright © 2018 Francisco Soares. All rights reserved.
//

import Foundation
import CoreData


class Hospital : NSManagedObject {
    
    @NSManaged var name : String
    @NSManaged var address : String
    
    
    convenience init(name : String, address: String, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Hospital", in: context)
        self.init(entity: entity!, insertInto: context)
        self.name = name
        self.address = address
    }
    
}
