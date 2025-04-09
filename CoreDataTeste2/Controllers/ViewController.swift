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
        self.shifts = PersistenceManager.shared.loadShifts()
        collectionView.reloadData()
    }

    /// Salva alterações aos dados: modificações, criação de dados novos, novas associações, etc.
    ///
    func save() {
        PersistenceManager.shared.saveContext()
    }
}
