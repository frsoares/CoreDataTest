//
//  Hospital.swift
//  CoreDataTeste2
//
//  Created by Francisco Soares on 26/04/18.
//  Copyright © 2018 Francisco Soares. All rights reserved.
//

import Foundation
import CoreData

public class Hospital: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var address: String
    @NSManaged var shifts: NSSet

    convenience init(name: String, address: String, shifts: NSSet = [], context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Hospital", in: context)
        self.init(entity: entity!, insertInto: context)
        self.name = name
        self.address = address
        self.shifts = shifts
    }

}
