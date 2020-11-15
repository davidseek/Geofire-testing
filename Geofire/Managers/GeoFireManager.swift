//
//  GeoFireManager.swift
//  Geofire
//
//  Created by David Seek on 11/15/20.
//

import Foundation
import FirebaseDatabase

final class GeoFireManager {

    /// Firebase database reference
    private let reference = Database.database().reference()
    
    /// Reference to the actual child path within the firebase reference
    /// Pointing to the locations node
    private let geoFire: GeoFire

    /// Reference we need to keep to remove observers
    /// Important if we want to create a new query around a coordinate
    private var circleQuery: GFCircleQuery?
    
    /// Array that holds the queried objects in the class
    private var objects: [GeoFireObject] = [] {
        didSet {
            locationObserver?(objects)
        }
    }
    
    /// Observer we need to use to "load" the objects over and over again
    /// Without having to query from the database over and over again
    public var locationObserver: (([GeoFireObject]) -> Void)?

    init(locationManager: LocationManager) {

        /// The geofire reference equals the locations reference of the database
        self.geoFire = GeoFire.init(firebaseRef: reference.child("Locations"))
    }
    
    // MARK: - Public
    
    /// With this function we can load the available objects
    public func setLocationObserver(onChange: @escaping ([GeoFireObject]) -> Void) {
        locationObserver = onChange
    }

    /// With this function we want to uplooad the current user's location into the geofire reference
    /// The idea is, that other users are then able to crawl his location
    /// And see him in the list of available locations
    public func setLocation(for userID: String, _ location: CLLocation) {
        print("setLocation for \(userID) at location: \(String(describing: location))")
        geoFire.setLocation(location, forKey: userID)
    }

    /// The function to actually query all available locations around a given coordinate
    /// Location equals the center around a request
    /// CLLocation(latitude: 37.7832889, longitude: -122.4056973)
    /// And the radius is the radius of the search around the center
    public func queryLocation(_ location: CLLocation, userID: String, radius: Int = 200) {

        /// Create a new circle query from center of the location to a given radius
        circleQuery = geoFire.query(at: location, withRadius: Double(radius))
        /// Remove all observers to make sure we're not adding requests
        circleQuery?.removeAllObservers()
        /// And start the observer
        /// It will load all current locations and
        /// will also fire whenever a user enters or leaves the radius
        circleQuery?.observe(.keyEntered) { [weak self] query, location in
            /// Here we want to prevent to show ourselves in the list of results
            guard query != userID else {
                return
            }
            /// Lastly we need to add the new found object to our array 
            self?.append(GeoFireObject(query: query, location: location))
        }
    }

    // MARK: - Private
    
    private func append(_ object: GeoFireObject) {
        /// When we append a location
        /// we need to first delete the old equivalent in case we're updating
        objects.remove(object: object)
        /// Then we want to add the new object
        objects.append(object)
    }
}
