//
//  LocationTest.swift
//  BaliBookEvents
//
//  Created by Saputra on 21/04/25.
//

import SwiftUI

struct LocationTest: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
            VStack {
                if let coordinate = locationManager.lastKnownLocation {
                    Text("Latitude: \(coordinate.latitude)")
                    
                    Text("Longitude: \(coordinate.longitude)")
                } else {
                    Text("Unknown Location")
                }
                
                
                Button("Get location") {
                    locationManager.checkLocationAuthorization()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
}

#Preview {
    LocationTest()
}
