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
    
}
