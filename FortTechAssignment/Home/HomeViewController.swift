//
//  HomeViewController.swift
//  FortTechAssignment
//
//  Created by Priyanka Kumari on 23/09/23.
//

import UIKit

class HomeViewController: UIViewController {

    let homeCollectionView = HomeCollectionView()
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchHomeData(completion: { [weak self] homeDataArray in
            guard let `self` = self else { return }
            homeCollectionView.homeDataArray = homeDataArray
            homeCollectionView.collectionView.reloadData()
        })
    }
    
    func setupHomeCollectionView() {
        homeCollectionView.backgroundColor = .yellow
        view.addSubview(homeCollectionView)
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    

}
