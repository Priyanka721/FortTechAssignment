//
//  MainViewController.swift
//  FortTechAssignment
//
//  Created by Priyanka Kumari on 23/09/23.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        getUserLocation()
        title = "View"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }

    func getUserLocation() {
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                self.addMapPinWithLocation(with: location)
                let dispatchWorkItem = DispatchWorkItem { [weak self] in
                    guard let `self` = self else { return }
                    self.navigateToHomeViewController()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: dispatchWorkItem)
            }
        }
    }
    
    func addMapPinWithLocation(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
        map.addAnnotation(pin)
        LocationManager.shared.setLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
    }
    
    func navigateToHomeViewController() {
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
}
