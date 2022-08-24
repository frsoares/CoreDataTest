//
//  AppDelegate.swift
//  CoreDataTeste2
//
//  Created by Francisco Soares on 26/04/18.
//  Copyright © 2018 Francisco Soares. All rights reserved.
//

import UIKit
import CoreData

public typealias UIApplicationLaunchOptionsKey = UIApplication.LaunchOptionsKey

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

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
