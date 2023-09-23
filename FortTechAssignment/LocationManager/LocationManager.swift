//
//  LocationManager.swift
//  FortTechAssignment
//
//  Created by Priyanka Kumari on 23/09/23.
//

import Foundation
import CoreLocation

//CLLocationManager has a objective-C dependency, so the easiest way to implement those methods is to subclass NSObject
class LocationManager: NSObject {
    public static let shared = LocationManager()
    public var locationManager: CLLocationManager = CLLocationManager()
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    public func setLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, preferredLocale: .current) { placeMarks, error in
            guard let place = placeMarks?.first, error == nil else {
                completion(nil)
                return
            }
            debugPrint("place", place)
            var name = ""
            if let locality = place.locality {
                name += locality
            }
            if let adminArea = place.administrativeArea {
                name += ", \(adminArea)"
            }
            completion(name)
        }
    }
}
extension LocationManager: CLLocationManagerDelegate {

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
//        manager.stopUpdatingLocation()
    }
}
