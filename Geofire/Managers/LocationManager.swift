//
//  LocationManager.swift
//  Geofire
//
//  Created by David Seek on 11/15/20.
//

import Foundation
import MapKit

final class LocationManager: NSObject {

    /// Current user's GPS location
    /// Taken from the GPS sensor or the phone
    public var gpsLocation: CLLocation? {
        return locationManager.location
    }
    
    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
    }

    /// Function to return lat/lng from an address
    /// Can be used to add a bunch of test addresses
    /// Or later in the product lifecycle to add custom addresses
    public func getCoordinates(from address: String, onSuccess: @escaping (CLLocationCoordinate2D?) -> Void) {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemark, error) in
        
            guard error == nil else {
                print(error?.localizedDescription ?? "Something went wrong while converting coords")
                onSuccess(nil)
                return
            }
            
            guard let placemark = placemark,
                  let location = placemark.first?.location?.coordinate else{
                onSuccess(nil)
                return
            }
            
            onSuccess(location)
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {

    /// Only used right now for debugging.
    /// So we know the current status of the permission access
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {

        case .notDetermined: print("notDetermined")
        case .authorizedWhenInUse: print("authorizedWhenInUse")
        case .authorizedAlways: print("authorizedAlways")
        case .restricted: print("restricted")
        case .denied: print("denied")
        default: print("ran into undiscovered case")
        }
    }
}
