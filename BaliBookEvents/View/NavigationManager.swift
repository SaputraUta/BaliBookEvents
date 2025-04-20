//
//  NavigationManager.swift
//  BaliBookEvents
//
//  Created by Saputra on 20/04/25.
//

import Foundation
import SwiftData
import SwiftUI

struct NavigationState: Codable, Hashable {
    enum Destination: Codable, Hashable {
        case event(UUID)
        case organizer(UUID)
    }
    
    var path: [Destination] = []
}

//@MainActor
class NavigationViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @AppStorage("savedNavigationState") private var savedNavigationState: Data?
    
    private var pathState: [NavigationState.Destination] = []
    
    func loadSavedPath(context: ModelContext) {
        guard let savedData = savedNavigationState,
              let decodedState = try? JSONDecoder().decode(NavigationState.self, from: savedData) else {
            return
        }
        
        path = NavigationPath()
        pathState = []
        
        for destination in decodedState.path {
            switch destination {
            case .event(let eventID):
                if let event = try? context.fetch(FetchDescriptor<Event>(predicate: #Predicate { $0.id == eventID })).first {
                    path.append(event)
                    pathState.append(destination)
                }
            case .organizer(let organizerID):
                if let organizer = try? context.fetch(FetchDescriptor<Organizer>(predicate: #Predicate { $0.id == organizerID})).first {
                    path.append(organizer)
                    pathState.append(destination)
                }
            }
        }
    }
    
    func saveCurrentPath() {
        let state = NavigationState(path: pathState)
        let encoder = JSONEncoder()
        savedNavigationState = try? encoder.encode(state)
    }
    
    func navigateToEvent(_ event: Event) {
        path.append(event)
        pathState.append(.event(event.id))
        saveCurrentPath()
    }
    
    func navigateToOrganizer(_ organizer: Organizer) {
        path.append(organizer)
        pathState.append(.organizer(organizer.id))
        saveCurrentPath()
    }
    
    func popPath() {
        guard !pathState.isEmpty else { return }
        pathState.removeLast()
        saveCurrentPath()
    }
    
    func clearPath() {
        path = NavigationPath()
        pathState = []
        savedNavigationState = nil
    }
}
