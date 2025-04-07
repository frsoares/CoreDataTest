//
//  Shift.swift
//  CoreDataTeste2
//
//  Created by Francisco Soares on 26/04/18.
//  Copyright © 2018 Francisco Soares. All rights reserved.
//

import Foundation
import CoreData

/// Entidade `Shift`
///
/// um exemplo de criação de entidade no modo categoria/extensão
/// (ver o arquivo xcdatamodel que deve estar configurado dessa maneira)
public class Shift: NSManagedObject {
    func myNameIs() -> String {
        return self.doctor?.name! ?? ""
    }
}
