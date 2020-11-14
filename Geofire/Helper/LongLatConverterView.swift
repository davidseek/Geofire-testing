//
//  LongLatConverterView.swift
//  Geofire
//
//  Created by Tee Becker on 11/14/20.
//

import SwiftUI
import CoreLocation

// takes in an address and returns long and lat coords.

struct CoordinateConvert{
    
    func convertAddressToCoords(for address: String, completion: @escaping (_ location: CLLocationCoordinate2D?) -> Void) {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemark, error) in
        
            if error != nil {
                print(error?.localizedDescription ?? "Something went wrong while converting coords")
            }
            
            guard let placemark = placemark,
                  let location = placemark.first?.location?.coordinate
            else{
                completion(nil)
                return
            }
            
            completion(location)
        }
    }
}
