//
//  ContentView.swift
//  BaliBookEvents
//
//  Created by Saputra on 18/04/25.
//

import SwiftData
import SwiftUI


struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var locationManager = LocationManager()
    
    let buttonArray = ["All", "This Weekend", "Nearest", "Free"]
    @State private var searchText = ""
    @Query private var events: [Event]
    @State private var selectedFilter = "All"
    
    var filteredEvents : [Event] {
        let matchesSearch: (Event) -> Bool = { event in
            searchText.isEmpty || event.title.localizedCaseInsensitiveContains(searchText)
        }
        
        switch selectedFilter {
            
        case "Free":
            return events.filter { matchesSearch($0) && $0.entryFee == 0 }
            
        case "This Weekend":
            return events.filter { matchesSearch($0) && isThisWeekend( $0.date) }
            
        case "Nearest":
            guard let userCoord = locationManager.lastKnownLocation else { return [] }
            return events
                .filter {
                    matchesSearch($0)
                }
                .sorted {
                    $0.distance(from: userCoord) < $1.distance(from: userCoord)
                }
            
        default:
            return events.filter(matchesSearch)
        }
    }
    
    private func isThisWeekend(_ date: Date) -> Bool {
        let calendar = Calendar.current
        guard let nextSaturday = calendar.nextDate(after: Date(), matching: DateComponents(weekday: 7), matchingPolicy: .nextTimePreservingSmallerComponents),
              let nextSunday = calendar.date(byAdding: .day, value: 1, to: nextSaturday) else {
            return false
        }
        
        return calendar.isDate(date, inSameDayAs: nextSaturday) || calendar.isDate(date, inSameDayAs: nextSunday)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 18) {
                    ForEach(buttonArray, id: \.self) { text in
                        FilterButton(text: text, selectedFilter: $selectedFilter)
                            .sensoryFeedback(.selection, trigger: selectedFilter)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                EventListView(events: filteredEvents, locationManager: locationManager)
            }
            .searchable(text: $searchText, prompt: "Search event")
        }
        .onAppear {
            locationManager.checkLocationAuthorization()
        }
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
        date: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
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
    
    container.mainContext.insert(organizer)
    container.mainContext.insert(event1)
    container.mainContext.insert(event2)
    container.mainContext.insert(event3)
    container.mainContext.insert(event4)
    
    return ContentView()
        .modelContainer(container)
}
