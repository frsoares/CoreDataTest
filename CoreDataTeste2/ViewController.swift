//
//  ViewController.swift
//  CoreDataTeste2
//
//  Created by Francisco Soares on 26/04/18.
//  Copyright © 2018 Francisco Soares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let doctor = Doctor(context: context)
        doctor.name = "Juliana"
        doctor.school = "UFPE"
        doctor.crm = "1234567890"
        
        let hospital = Hospital(name: "HC", address: "av. Jorn..." , context: context)
        //        hospital.name = "HC"
        //        hospital.address = "av. Jornalista Arthur Sá"
        
        let du = Duty(context: context)
        du.doctor = doctor
        du.duration = 12
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

