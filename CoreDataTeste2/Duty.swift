//
//  Duty.swift
//  CoreDataTeste2
//
//  Created by Francisco Soares on 26/04/18.
//  Copyright © 2018 Francisco Soares. All rights reserved.
//

import Foundation
import CoreData

class Duty : NSManagedObject {
    func myNameIs() -> String {
        
        print(true==true ? "sim":"não")
        
        return self.doctor?.name! ?? ""
    }
}
