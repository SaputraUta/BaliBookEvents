//
//  DetailEventView.swift
//  BaliBookEvents
//
//  Created by Saputra on 19/04/25.
//

import SwiftData
import SwiftUI

struct DetailEventView: View {
    let event: Event
    
    @State private var isShowingFullDescription = false
    @State private var selectedImage: WrappedImage? = nil
    @ObservedObject var locationManager: LocationManager
    @State private var lastDragValue: CGFloat = 0
    
    var shouldShowSeeMore: Bool {
        return event.desc.count > 120
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading ,spacing: 8){
                Group {
                    if let name = event.pamphletURL, let uiImage = UIImage(named: name) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    } else {
                        Color.gray
                    }
                }
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(event.title)
                        .font(.title2.bold())
                    NavigationLink(value: event.organizer) {
                        HStack(spacing: 2) {
                            Image(systemName: "person.fill")
                            Text(event.organizer?.name ?? "Unknown")
                                .underline()
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.blue)
                    
                    Divider()
                        .padding(.top, 12)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack() {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "calendar")
                                Text(event.date.formatted(date: .abbreviated, time: .omitted))
                            }
                            HStack {
                                Image(systemName: "clock.fill")
                                Text("\(event.time)")
                            }
                            HStack {
                                Image(systemName: "wallet.bifold.fill")
                                Text(event.entryFee == 0 ? "FREE" : event.entryFee.formatted(.currency(code: "IDR")))
                            }
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "location")
                                if let userCoord = locationManager.lastKnownLocation {
                                    let distanceInMeters = event.distance(from: userCoord)
                                    let formatted = distanceInMeters > 1000 ?
                                    String(format: "%.1f km", distanceInMeters / 1000)
                                    : String(format: ".0f km", distanceInMeters)
                                    Text(formatted)
                                } else {
                                    Text("Location unknown")
                                }
                            }
                            HStack {
                                Image(systemName: "mappin")
                                Text(event.locationName)
                            }
                            .foregroundStyle(.blue)
                            .underline()
                            .onTapGesture {
                                if let url = URL(string: "http://maps.apple.com/?ll=\(event.latitude),\(event.longtitude)") {
                                    UIApplication.shared.open(url)
                                    let generator = UISelectionFeedbackGenerator()
                                    
                                    generator.prepare()
                                    generator.selectionChanged()
                                }
                            }
                            HStack {
                                Image(systemName: "phone")
                                Text(event.contactPerson)
                            }
                        }
                    }
                    .font(.callout)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(event.desc)
                            .lineLimit(isShowingFullDescription ? nil : 2)
                            .font(.callout)
                        if shouldShowSeeMore {
                            HStack {
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        isShowingFullDescription.toggle()
                                    }
                                }) {
                                    Text(isShowingFullDescription ? "See Less" : "See More")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.blue)
                                }
                                .sensoryFeedback(.selection, trigger: isShowingFullDescription)
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .foregroundStyle(.black.opacity(0.8))
                
                Divider()
                    .padding(.top, 4)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Past Events Documentation")
                        .font(.title3)
                    
                    ScrollView(.horizontal) {
                        if event.organizer?.pastEventPhotoURLs.isEmpty == true {
                            Text("No past event documentation")
                        } else if let urls = event.organizer?.pastEventPhotoURLs {
                            LazyHStack(spacing: 8) {
                                ForEach(urls, id: \.self) { url in
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
                .padding(.horizontal)
            }
            .scrollBounceBehavior(.basedOnSize)
            .sheet(item: $selectedImage) { item in
                    Image(uiImage: item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Event Detail")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Organizer.self) { organizer in
                OrganizerDetailView(organizer: organizer)
            }
        }
    }
}

#Preview {
    
    let organizer = Organizer(id: UUID(),
                              name: "Yayasan Mudra Swari Saraswati",
                              contactPerson: "+62 123 456 7890",
                              websiteURL: nil,
                              desc: "A community for book lovers.",
                              jargon: "Read, Share, Grow",
                              pastEventPhotoURLs: ["image1","image4","image5","image2","image6","image7"]
    )
    
    let event1 = Event(
        id: UUID(),
        title: "Bali Book Club Meetup: Discussing \"The Night Circus\"",
        organizer: organizer,
        date: Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 14)) ?? Date(),
        entryFee: 0,
        locationName: "KAFE Ubud, Gianyar, Bali",
        latitude: -8.5069,
        longtitude: 115.2625,
        pamphletURL: "image3",
        time: "18:00-20:00",
        contactPerson: "+62 123 456 7890",
        desc: "The Ubud Writers & Readers Festival 2024 is a five-day celebration of literature, culture, and ideas, bringing together renowned authors, poets, and thinkers from around the world. Held in the heart of Ubud, the festival."
    )
    
    DetailEventView(event: event1, locationManager: LocationManager())
}
