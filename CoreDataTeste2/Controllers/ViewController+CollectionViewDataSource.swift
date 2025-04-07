//
//  ViewController+CollectionViewDataSource.swift
//  CoreDataTeste2
//
//  Created by Francisco Miranda Soares on 07/04/25.
//  Copyright © 2025 Francisco Soares. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shifts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? CellCollectionViewCell
        cell?.configure(with: shifts[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
}
