//
//  EventListView.swift
//  BaliBookEvents
//
//  Created by Saputra on 18/04/25.
//

import SwiftUI
import SwiftData

struct EventListView: View {
    var events : [Event]
    @ObservedObject var locationManager: LocationManager
    
    init(events: [Event], locationManager: LocationManager) {
        self.events = events
        self.locationManager = locationManager
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(events, id: \.id) { event in
                    NavigationLink(value: event) {
                        EventCardView(event: event)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .navigationTitle("Event List")
        .navigationDestination(for: Event.self) { event in
            DetailEventView(event: event, locationManager: locationManager)
        }
        .padding(.top, -12)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Event.self, Organizer.self, configurations: config)
    
    let organizer = Organizer(
        id: UUID(),
        name: "Yayasan Mudra Swari",
        contactPerson: "+62 123 456 7890",
        websiteURL: "www.mudraswari.org",
        desc: "Yayasan Mudra Swari Saraswati is dedicated to fostering cultural enrichment and educational opportunities in Bali. We organize a variety of events, from literary and artistic workshops to cultural festivals, all aimed at inspiring our community and supporting local talent.",
        jargon: "Organizing cultural and educational events in Ubud, Bali.",
        pastEventPhotoURLs: ["image1", "image4", "image5"]
    )
    
    let event1 = Event(
        id: UUID(),
        title: "Ubud Writers & Readers Festival 2024",
        organizer: organizer,
        date: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
        entryFee: 150_000,
        locationName: "Ubud Palace",
        latitude: -8.5190,
        longtitude: 115.2630,
        pamphletURL: "image2",
        time: "10:00 - 17:00",
        contactPerson: "+62 811 2222 3333",
        desc: "An international literary gathering in the heart of Ubud."
    )
    
    let event2 = Event(
        id: UUID(),
        title: "Balinese Art & Culture Workshop",
        organizer: organizer,
        date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
        entryFee: 100_000,
        locationName: "Museum Puri Lukisan",
        latitude: -8.5069,
        longtitude: 115.2642,
        pamphletURL: "image3",
        time: "13:00 - 15:00",
        contactPerson: "+62 822 3456 7890",
        desc: "Explore traditional Balinese painting and sculpture techniques."
    )
    
    let event3 = Event(
        id: UUID(),
        title: "Upcoming Yoga & Wellness Day",
        organizer: organizer,
        date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
        entryFee: 80_000,
        locationName: "Yoga Barn Ubud",
        latitude: -8.5141,
        longtitude: 115.2605,
        pamphletURL: "image6",
        time: "08:00 - 12:00",
        contactPerson: "+62 878 9999 8888",
        desc: "A day of relaxation, movement, and mindful breathing."
    )
    
    let event4 = Event(
        id: UUID(),
        title: "Bali Cultural Parade",
        organizer: organizer,
        date: Calendar.current.date(byAdding: .day, value: -15, to: Date())!,
        entryFee: 0,
        locationName: "Ubud Main Street",
        latitude: -8.5196,
        longtitude: 115.2632,
        pamphletURL: "image7",
        time: "17:00 - 20:00",
        contactPerson: "+62 812 1234 5678",
        desc: "A festive celebration of Bali's vibrant cultural traditions."
    )
    
    let events = [event1, event2, event3, event4]
    
    container.mainContext.insert(organizer)
    container.mainContext.insert(event1)
    container.mainContext.insert(event2)
    container.mainContext.insert(event3)
    container.mainContext.insert(event4)
    
    return EventListView(events: events, locationManager: LocationManager())
        .modelContainer(container)
}

