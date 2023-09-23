//
//  HomeCollectionView.swift
//  FortTechAssignment
//
//  Created by Priyanka Kumari on 23/09/23.
//

import UIKit

public protocol HomeCollectionViewDelegate: AnyObject {
    func setLatLongAndDate(latLong: String, dateTime: String)
}

public class HomeCollectionView: UIView {
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    public weak var delegate: HomeCollectionViewDelegate?
    var homeDataArray = [HomeDataModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ConfigureCollectionView()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ConfigureCollectionView()
        setupCollectionView()
    }
    
    private func ConfigureCollectionView() {
        addSubview(collectionView)
        collectionView.backgroundColor = .orange
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height / 5)
        layout.itemSize = CGSize(width: self.collectionView.frame.size.width, height: 100)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
    }

}

// MARK: - UICollectionView DataSource and Delegate
extension HomeCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeDataArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier,
            for: indexPath) as? HomeCollectionViewCell
        else { fatalError("Cannot create new cell") }
        cell.backgroundColor = .systemYellow
        cell.setupUI(model: homeDataArray[indexPath.row])
        return cell
    }
    
    
}
extension HomeCollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
