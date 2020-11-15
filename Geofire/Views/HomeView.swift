//
//  HomeView.swift
//  Geofire
//
//  Created by Tee Becker on 11/12/20.
//

import SwiftUI
import CoreLocation

/// We do not want the View layer to handle any actions
/// That's why we're just emiting whatever action took place
/// to the logical layers of the application
/// Separation of concerns
enum HomeViewAction {
    case didRequestLogout
}

struct HomeView: View {
    
    /// The action handler we will trigger when anything happens
    /// We'll make it optional so the preview isn't losing it's shit
    private let actionHandler: ((HomeViewAction) -> Void)?

    @Binding private var locations: [GeoFireObject]
    
    init(locations: Binding<[GeoFireObject]>, onAction: ((HomeViewAction) -> Void)? = nil) {
        self._locations = locations
        actionHandler = onAction
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 10) {
                    
                    /// This should not be necessary.
                    /// The default should always be, that the user sees what's around him
                    /// Taken from the location of the phone
                    
//                    HStack {
//                        TextField("Enter an address", text: $currentAddress)
//                            .font(.title2)
//                            .frame(height: 45)
//                            .padding(.leading)
//
//                        Button(action: {
//
//                            CoordinateConvert().convertAddressToCoords(for: currentAddress) { (location) in
//                                print("Longitude is \(String(describing: location?.longitude))")
//                                print("Latitude is: \(String(describing: location?.latitude))")
//                            }
//                        }) {
//                            Text("Search")
//                        }
//                        .frame(height: 45)
//                        .padding(.leading)
//                        .padding(.trailing)
//
//                    }
                    
                    ForEach(locations) { location in
                        Text(location.query)
                    }
                    
                    Button(action:{
                        actionHandler?(.didRequestLogout)
                    }) {
                        Text("Sign Out")
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.2))
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(locations: .constant([]))
    }
}
