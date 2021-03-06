//
//  ViewController.swift
//  CoreDataTeste2
//
//  Created by Francisco Soares on 26/04/18.
//  Copyright © 2018 Francisco Soares. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let shiftRequest = NSFetchRequest<Shift>(entityName: "Shift")
        let shifts = try! context.fetch(shiftRequest)
        if !shifts.isEmpty {
            for shift in shifts{
                print(shift)
            }
        }
        else{
            let doctorRequest = NSFetchRequest<Doctor>(entityName: "Doctor")
            let doctors : [Doctor] = try! context.fetch(doctorRequest)
            let doctor : Doctor
            if doctors.isEmpty {
                doctor = Doctor(context: context)
                doctor.name = "Juliana"
                doctor.school = "UFPE"
                doctor.crm = "1234567890"
            }
            else {
                doctor = doctors.first!
            }
            let hospitalRequest = NSFetchRequest<Hospital>(entityName: "Hospital")
            let hospitals = try! context.fetch(hospitalRequest)
            
            let hospital : Hospital = hospitals.first ??  Hospital(name: "HC", address: "av. Professor Moraes Rego" , context: context)
            
            let sh = Shift(context: context)
            sh.doctor = doctor
            sh.duration = 12
            sh.hospital = hospital
        
            print(sh)
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
}

