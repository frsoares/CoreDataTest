//
//  PersistenceManager.swift
//  CoreDataTeste2
//
//  Created by Francisco Miranda Soares on 07/04/25.
//  Copyright © 2025 Francisco Soares. All rights reserved.
//

import CoreData

class PersistenceManager {

    static let shared = PersistenceManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        // usa name para procurar o arquivo .xcdatamodel no projeto que possui o mesmo nome
        let container = NSPersistentCloudKitContainer(name: "CoreDataTeste2")

        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        // description
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Could not load description for the first persistentStore")
        }
        print("Loaded CoreData persistent store '\(description)'")

        // initialize schema
        do {
            try container.initializeCloudKitSchema()
        } catch {
            print("---------")
            print("An error occurred trying to save a cloudkit schema from a xcdatamodel.")
            print("The error: '\(error.localizedDescription)'")
            print("---------")
        }

        // updates automatically stuff that comes from other places
        container.viewContext.automaticallyMergesChangesFromParent = true

        return container
    }()

    func loadShifts() -> [Shift] {

        let context = persistentContainer.viewContext

        /// Carregando elementos do tipo `Shift`
        let shiftRequest = NSFetchRequest<Shift>(entityName: "Shift")
        var shifts = (try? context.fetch(shiftRequest)) ?? []
        if !shifts.isEmpty {
            for shift in shifts {
                print(shift)
            }
        } else {
            let newShift = createExampleShift(with: context)
            print(newShift)
            shifts.append(newShift)
            self.saveContext()
        }
        return shifts
    }

    /// Cria um único `Shift` de exemplo
    ///
    /// No processo, acabamos criando um `Doctor` e um `Hospital`,
    /// partes das relações dentro de `Shift`.
    private func createExampleShift(with context: NSManagedObjectContext) -> Shift {
        /// Carregando elementos do tipo `Doctor`
        let doctorRequest = NSFetchRequest<Doctor>(entityName: "Doctor")
        let doctors: [Doctor] = (try? context.fetch(doctorRequest)) ?? []
        let doctor: Doctor
        if doctors.isEmpty {
            doctor = Doctor(context: context)
            doctor.name = "Juliana"
            doctor.school = "UFPE"
            doctor.crm = "1234567890"
        } else {
            doctor = doctors.first!
        }
        let hospitalRequest = NSFetchRequest<Hospital>(entityName: "Hospital")
        let hospitals = (try? context.fetch(hospitalRequest)) ?? []

        let hospital: Hospital = hospitals.first ??
        Hospital(name: "HC", address: "av. Professor Moraes Rego", context: context)

        // todo 'carregamento' anterior foi para criar um `Shift` novo, pois esse precisa de
        // um médico e um hospital
        let newShift = Shift(context: context)
        newShift.doctor = doctor
        newShift.duration = 12
        newShift.hospital = hospital
        return newShift
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("An error occurred saving context: '\(error)', '\(error.localizedDescription)'")
            }
        }
    }

}
