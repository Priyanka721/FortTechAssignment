//
//  HomeCollectionViewCell.swift
//  FortTechAssignment
//
//  Created by Priyanka Kumari on 23/09/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeCollectionViewCellIdentifier"
    
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let latLongLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textAlignment = .center
        return label
    }()
    private let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "World"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTable()
    }
    
    func setupTable() {
        cellStackView.addArrangedSubview(latLongLabel)
        cellStackView.addArrangedSubview(dateTimeLabel)
        
        contentView.addSubview(cellStackView)
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            cellStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            latLongLabel.heightAnchor.constraint(equalToConstant: 40),
            dateTimeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
