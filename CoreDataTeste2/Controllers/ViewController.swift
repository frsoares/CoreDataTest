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

    // recomendado porque escrever esse acesso a AppDelegate toda vez é um saco
    // e pode ser utilizado várias vezes em outras funções em contextos reais
    let container = (UIApplication.shared.delegate as? AppDelegate)?
        .persistentContainer

    var shifts: [Shift] = [Shift]()

    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.register(
            CellCollectionViewCell.self,
            forCellWithReuseIdentifier: CellCollectionViewCell.cellIdentifier
        )

        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        self.title = "Plantões"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        loadData()
    }

}

// MARK: - CoreData
extension ViewController {

    /// Carrega dados do CoreData, mas cria um elemento se os dados não existirem
    func loadData() {
        guard let context = container?.viewContext else { return }

        /// Carregando elementos do tipo `Shift`
        let shiftRequest = NSFetchRequest<Shift>(entityName: "Shift")
        let shifts = (try? context.fetch(shiftRequest)) ?? []
        if !shifts.isEmpty {
            for shift in shifts {
                print(shift)
            }
            self.shifts = shifts
        } else {
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

            print(newShift)
            self.shifts.append(newShift)
            save()
        }
        collectionView.reloadData()
    }

    /// Salva alterações aos dados: modificações, criação de dados novos, novas associações, etc.
    ///
    /// Recomendado como função separada porque escrever esse acesso a AppDelegate toda vez é um saco
    func save() {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
