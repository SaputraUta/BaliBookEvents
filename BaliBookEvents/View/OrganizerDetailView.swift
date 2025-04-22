//
//  OrganizerDetailView.swift
//  BaliBookEvents
//
//  Created by Saputra on 19/04/25.
//

import SwiftUI

struct OrganizerDetailView: View {
    let organizer: Organizer
    
    @State private var showFullDescription = false
    @State private var selectedImage: WrappedImage? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(organizer.name)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(organizer.jargon)
                        .font(.footnote)
                    
                    HStack {
                        HStack {
                            Image(systemName: "phone")
                            Text(organizer.contactPerson)
                        }
                        Spacer()
                        if organizer.websiteURL != nil {
                            HStack {
                                Image(systemName: "globe")
                                Text(organizer.websiteURL ?? "N/A")
                            }
                            .foregroundStyle(.blue)
                            .underline()
                            .onTapGesture {
                                if let urlString = URL(string: "https://" + (organizer.websiteURL ?? "")) {
                                    UIApplication.shared.open(urlString)
                                    let generator = UISelectionFeedbackGenerator()
                                    
                                    generator.prepare()
                                    generator.selectionChanged()
                                }
                            }
                        }
                    }
                    .font(.footnote)
                    .padding(.top, 6)
                }
                .foregroundStyle(.black.opacity(0.8))
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("About")
                        .font(.system(size: 17))
                    Text(organizer.desc)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.footnote)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showFullDescription.toggle()
                            }
                        }){
                            Text(showFullDescription ? "Show Less" : "Show More")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.blue)
                        }
                        .sensoryFeedback(.selection, trigger: showFullDescription)
                        
                        Spacer()
                    }
                }
                .foregroundStyle(.black.opacity(0.8))
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Upcoming Events")
                        .font(.title2)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(organizer.events) { event in
                                NavigationLink(value: event) {
                                    if let url = event.pamphletURL, !url.isEmpty {
                                        Image(url)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 162, height: 162)
                                            .clipShape(Rectangle())
                                    }
                                }
                            }
                        }
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Past Events Documentation")
                        .font(.title2)
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 8) {
                            ForEach(organizer.pastEventPhotoURLs, id: \.self) { url in
                                if let uiImage = UIImage(named: url) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 162, height: 162)
                                        .clipShape(Rectangle())
                                        .onTapGesture {
                                            selectedImage = WrappedImage(image: uiImage)
                                            let generator = UISelectionFeedbackGenerator()
                                            
                                            generator.prepare()
                                            generator.selectionChanged()
                                        }
                                } else {
                                    Color.gray
                                        .frame(width: 162, height: 162)
                                }
                                
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Organizer Detail")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedImage) { item in
            Image(uiImage: item.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    let organizer = Organizer(
        id: UUID(),
        name: "Yayasan Mudra Swari",
        contactPerson: "+62 123 456 7890",
        websiteURL: "www.mudraswari.org",
        desc: "Yayasan Mudra Swari Saraswati is dedicated to fostering cultural enrichment and educational opportunities in Bali. We organize a variety of events, from literary and artistic workshops to cultural festivals, all aimed at inspiring our community and supporting local talent.",
        jargon: "Organizing cultural and educational events in Ubud, Bali.",
        pastEventPhotoURLs: ["image1", "image4", "image5"]
    )
    
    let sampleEvents: [Event] = [
        Event(
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
        ),
        Event(
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
        ),
        Event(
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
        ),
        Event(
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
    ]
    
    organizer.events = sampleEvents
    
    return OrganizerDetailView(organizer: organizer)
}
