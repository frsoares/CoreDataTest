//
//  CellCollectionViewCell.swift
//  CoreDataTeste2
//
//  Created by Francisco Soares on 26/04/18.
//  Copyright © 2018 Francisco Soares. All rights reserved.
//

import UIKit

class CellCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "CellCollectionViewCell"

    lazy var shiftNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var doctorNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var namesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with shift: Shift) {
        shiftNameLabel.text = shift.hospital?.name
        doctorNameLabel.text = shift.doctor?.name
    }

    private func setup() {
        addSubviews()
        setupConstraints()
        setupUIStyle()
    }

    private func addSubviews() {
        namesStackView.addArrangedSubview(shiftNameLabel)
        namesStackView.addArrangedSubview(doctorNameLabel)
        contentView.addSubview(namesStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            namesStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            namesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            namesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            namesStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8)
        ])
    }

    private func setupUIStyle() {
        self.contentView.backgroundColor = .medicalGreen
    }
}
