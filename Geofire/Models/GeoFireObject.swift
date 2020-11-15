//
//  GeoFireObject.swift
//  Geofire
//
//  Created by David Seek on 11/15/20.
//

import Foundation

struct GeoFireObject: Equatable, Identifiable {
    
    /// The query here is the object ID of what has been found
    /// Logically it would right now equal the ID of a user
    let query: String
    
    /// The physical location of the object
    /// Can be used for example to display elements on a map
    let location: CLLocation
    
    // MARK: - Identifiable
    var id: String {
        return query
    }
    
    // MARK: - Equatable
    static func == (lhs: GeoFireObject, rhs: GeoFireObject) -> Bool {
        return lhs.query == rhs.query
    }
}
