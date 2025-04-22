//
//  EventExtension.swift
//  BaliBookEvents
//
//  Created by Saputra on 21/04/25.
//

import Foundation
import CoreLocation

extension Event {
    func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let eventLocation = CLLocation(latitude: latitude, longitude: longtitude)
        let userLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return userLocation.distance(from: eventLocation)
    }
}
