//
//  EventCardView.swift
//  BaliBookEvents
//
//  Created by Saputra on 18/04/25.
//

import SwiftData
import SwiftUI

struct EventCardView: View {
    let event: Event
    var body: some View {
        HStack {
            Group {
                if let name = event.pamphletURL,
                    let uiImage = UIImage(named: name) {
                    Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                } else {
                    Color.gray
                }
            }
            .frame(width: 140, height: 140)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 2)
            
            VStack(alignment: .leading) {
                Text(event.title)
                    .frame(alignment: .leading)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                HStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 11, height: 11)
                    Text(event.organizer?.name ?? "Unknown Organizer")
                        .font(.caption2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: 150, alignment: .leading)
                        .padding(.leading, 0)
                }
                .padding(.leading, 0)
                .opacity(0.9)
                
                HStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 11, height: 11)
                    Text(event.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: 150, alignment: .leading)
                        .padding(.leading, 0)
                }
                .padding(.leading, 0)
                .opacity(0.9)
                
                HStack {
                    Image(systemName: "wallet.bifold")
                        .resizable()
                        .frame(width: 11, height: 11)
                    Text(event.entryFee == 0 ? "FREE" : event.entryFee.formatted(.currency(code: "IDR")))
                        .font(.caption2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: 150, alignment: .leading)
                        .padding(.leading, 0)
                }
                .padding(.leading, 0)
                .opacity(0.9)
                
                HStack {
                    Image(systemName: "mappin")
                        .resizable()
                        .frame(width: 5, height: 11)
                    Text(event.locationName)
                        .font(.caption2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: 150, alignment: .leading)
                        .padding(.leading, 4)
                }
                .padding(.leading, 0)
                .opacity(0.9)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(4)
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, maxHeight: 160)
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 2)
    }
}

#Preview {
    let organizer = Organizer(id: UUID(), name: "Yayasan Mudra Swari Saraswati", contactPerson: "John Doe", websiteURL: nil, desc: "A community for book lovers.", jargon: "Read, Share, Grow", pastEventPhotoURLs: [])
    
    let event = Event(
        id: UUID(),
        title: "Bali Book Club Meetup: Discussing \"The Night Circus\"",
        organizer: organizer,
        date: Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 14)) ?? Date(),
        entryFee: 0,
        locationName: "KAFE Ubud, Gianyar, Bali",
        latitude: -8.5069,
        longtitude: 115.2625,
        pamphletURL: "image1",
        time: "18:00-20:00",
        contactPerson: "+62 123 456 7890",
        desc: "Join us for a book discussion"
    )
    
    EventCardView(event: event)
}
