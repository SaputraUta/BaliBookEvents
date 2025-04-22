//
//  BaliBookEventsApp.swift
//  BaliBookEvents
//
//  Created by Saputra on 18/04/25.
//

import SwiftData
import SwiftUI

@main
struct BaliBookEventsApp: App {
    let container: ModelContainer
    
    init() {
            do {
                container = try ModelContainer(for: Event.self, Organizer.self)
                
                if !UserDefaults.standard.bool(forKey: "hasPreloadedData") {
                    populateSampleData()
                    UserDefaults.standard.set(true, forKey: "hasPreloadedData")
                }
            } catch {
                fatalError("Failed to create ModelContainer: \(error)")
            }
        }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
    
    func populateSampleData() {
        let context = container.mainContext
        
        let mudraSwari = Organizer(
            id: UUID(),
            name: "Yayasan Mudra Swari",
            contactPerson: "+62 123 456 7890",
            websiteURL: "mudraswari.org",
            desc: "Yayasan Mudra Swari Saraswati is dedicated to fostering cultural enrichment and educational opportunities in Bali. We organize a variety of events, from literary and artistic workshops to cultural festivals, all aimed at inspiring our community and supporting local talent.",
            jargon: "Organizing cultural and educational events in Ubud, Bali.",
            pastEventPhotoURLs: ["image1", "image4", "image5"]
        )
        
        let baliSpiritFestival = Organizer(
            id: UUID(),
            name: "Bali Spirit Festival",
            contactPerson: "+62 877 6420 7333",
            websiteURL: "balispiritfestival.com",
            desc: "The BaliSpirit Festival is a global celebration of yoga, dance, and music that brings together top international teachers, musicians, and dancers for a week of inspiration and discovery.",
            jargon: "Celebrating yoga, dance, and global wellness in the heart of Ubud.",
            pastEventPhotoURLs: ["image2", "image3", "image6"]
        )
        
        let kulkul = Organizer(
            id: UUID(),
            name: "Kulkul Farm & Events",
            contactPerson: "+62 812 3855 1234",
            websiteURL: "kulkulfarm.com",
            desc: "Kulkul is an organic farm and vibrant event space nestled in the rice fields of Tegallalang. We host farm-to-table dining experiences, workshops on sustainable living, and regular community markets featuring local artisans.",
            jargon: "Promoting sustainable living through immersive farm experiences and community events.",
            pastEventPhotoURLs: ["image7", "image1", "image4"]
        )
        
        let omniBali = Organizer(
            id: UUID(),
            name: "Omni Bali",
            contactPerson: "+62 819 3366 8877",
            websiteURL: "omnibali.co",
            desc: "Omni Bali creates cutting-edge tech conferences and networking events for digital nomads and the Bali startup ecosystem. Our mission is to foster innovation and collaboration among tech professionals in paradise.",
            jargon: "Connecting Bali's digital ecosystem through forward-thinking events.",
            pastEventPhotoURLs: ["image5", "image2", "image6"]
        )
        
        let event1 = Event(
            id: UUID(),
            title: "Ubud Writers & Readers Festival 2024",
            organizer: mudraSwari,
            date: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
            entryFee: 150_000,
            locationName: "Ubud Palace",
            latitude: -8.5190,
            longtitude: 115.2630,
            pamphletURL: "image2",
            time: "10:00 - 17:00",
            contactPerson: "+62 811 2222 3333",
            desc: "An international literary gathering in the heart of Ubud featuring over 150 writers, artists, activists, and performers from more than 30 countries. Join panel discussions, workshops, book launches, and cultural performances that celebrate the power of storytelling."
        )
        
        let event2 = Event(
            id: UUID(),
            title: "Balinese Art & Culture Workshop",
            organizer: mudraSwari,
            date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
            entryFee: 100_000,
            locationName: "Museum Puri Lukisan",
            latitude: -8.5069,
            longtitude: 115.2642,
            pamphletURL: "image3",
            time: "13:00 - 15:00",
            contactPerson: "+62 822 3456 7890",
            desc: "Explore traditional Balinese painting and sculpture techniques with master artists from the region. All materials provided, suitable for beginners and experienced artists alike."
        )
        
        let event3 = Event(
            id: UUID(),
            title: "Ubud Children's Book Festival",
            organizer: mudraSwari,
            date: Calendar.current.date(byAdding: .day, value: 15, to: Date())!,
            entryFee: 50_000,
            locationName: "Taman Baca",
            latitude: -8.5160,
            longtitude: 115.2610,
            pamphletURL: "image4",
            time: "09:00 - 16:00",
            contactPerson: "+62 878 6633 2211",
            desc: "A magical day of storytelling, puppet shows, and creative workshops designed to inspire young readers and celebrate children's literature from Indonesia and beyond."
        )
        
        let event4 = Event(
            id: UUID(),
            title: "Bali Spirit Festival 2024",
            organizer: baliSpiritFestival,
            date: Calendar.current.date(byAdding: .day, value: 25, to: Date())!,
            entryFee: 350_000,
            locationName: "Bona Yoga Center",
            latitude: -8.5141,
            longtitude: 115.2605,
            pamphletURL: "image5",
            time: "All Day",
            contactPerson: "+62 878 9999 8888",
            desc: "The 17th annual celebration of global consciousness through yoga, dance, and music. Join world-class teachers and performers for transformative workshops, ecstatic dance sessions, and nightly concerts under the stars."
        )
        
        let event5 = Event(
            id: UUID(),
            title: "New Moon Sound Healing",
            organizer: baliSpiritFestival,
            date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
            entryFee: 120_000,
            locationName: "Pyramids of Chi",
            latitude: -8.5032,
            longtitude: 115.2667,
            pamphletURL: "image6",
            time: "19:00 - 21:00",
            contactPerson: "+62 813 5555 4444",
            desc: "Experience deep relaxation through the healing vibrations of crystal bowls, gongs, and other sacred instruments during this special new moon ceremony. Please bring a yoga mat, pillow, and blanket for your comfort."
        )
        
        let event6 = Event(
            id: UUID(),
            title: "Flow and Glow: Yoga & Dance Workshop",
            organizer: baliSpiritFestival,
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
            entryFee: 85_000,
            locationName: "Yoga Barn",
            latitude: -8.5142,
            longtitude: 115.2608,
            pamphletURL: "image7",
            time: "16:00 - 18:30",
            contactPerson: "+62 812 8765 4321",
            desc: "Journey through a dynamic yoga practice followed by free-form ecstatic dance. Release stress, express yourself, and find freedom in movement. All levels welcome."
        )
        
        let event7 = Event(
            id: UUID(),
            title: "Farm-to-Table Dinner Experience",
            organizer: kulkul,
            date: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
            entryFee: 275_000,
            locationName: "Kulkul Farm",
            latitude: -8.4317,
            longtitude: 115.2851,
            pamphletURL: "image1",
            time: "17:30 - 21:00",
            contactPerson: "+62 812 3855 1234",
            desc: "Enjoy a guided tour of our organic gardens followed by a spectacular six-course dinner prepared with ingredients harvested just hours before your meal. Wine pairings available for additional fee."
        )
        
        let event8 = Event(
            id: UUID(),
            title: "Weekend Farmers Market",
            organizer: kulkul,
            date: Calendar.current.date(byAdding: .day, value: 6, to: Date())!,
            entryFee: 0,
            locationName: "Kulkul Farm",
            latitude: -8.4317,
            longtitude: 115.2851,
            pamphletURL: "image2",
            time: "08:00 - 13:00",
            contactPerson: "+62 812 3855 1234",
            desc: "Shop for fresh organic produce, artisanal foods, and handcrafted goods from local farmers and makers. Live acoustic music and coffee bar on site. Free entry, family-friendly event."
        )
        
        let event9 = Event(
            id: UUID(),
            title: "Permaculture Design Workshop",
            organizer: kulkul,
            date: Calendar.current.date(byAdding: .day, value: 12, to: Date())!,
            entryFee: 200_000,
            locationName: "Kulkul Learning Center",
            latitude: -8.4318,
            longtitude: 115.2853,
            pamphletURL: "image3",
            time: "09:00 - 15:00",
            contactPerson: "+62 812 3855 1234",
            desc: "Learn practical permaculture techniques for tropical climates. This hands-on workshop covers soil management, companion planting, water conservation, and creating a sustainable home garden. Includes organic lunch."
        )
        
        let event10 = Event(
            id: UUID(),
            title: "Bali Tech Summit",
            organizer: omniBali,
            date: Calendar.current.date(byAdding: .day, value: 18, to: Date())!,
            entryFee: 300_000,
            locationName: "Dojo Bali",
            latitude: -8.6513,
            longtitude: 115.1353,
            pamphletURL: "image4",
            time: "09:00 - 17:00",
            contactPerson: "+62 819 3366 8877",
            desc: "Join tech innovators, startup founders, and digital nomads for a day of inspiring talks, workshops, and networking. Topics include AI, blockchain, remote work trends, and sustainable tech solutions."
        )
        
        let event11 = Event(
            id: UUID(),
            title: "Crypto & Coffee Meetup",
            organizer: omniBali,
            date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
            entryFee: 0,
            locationName: "Zin Café",
            latitude: -8.5197,
            longtitude: 115.2610,
            pamphletURL: "image5",
            time: "10:00 - 12:00",
            contactPerson: "+62 819 3366 8877",
            desc: "Casual gathering for crypto enthusiasts to discuss latest trends, share insights, and connect with others in the space. First drink is on us!"
        )
        
        let event12 = Event(
            id: UUID(),
            title: "Digital Nomad Networking Night",
            organizer: omniBali,
            date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
            entryFee: 50_000,
            locationName: "Hubud",
            latitude: -8.5121,
            longtitude: 115.2611,
            pamphletURL: "image6",
            time: "18:30 - 21:30",
            contactPerson: "+62 819 3366 8877",
            desc: "Mix and mingle with Bali's vibrant community of digital nomads, remote workers, and location-independent entrepreneurs. Includes one welcome drink and light snacks."
        )
        
        let event13 = Event(
            id: UUID(),
            title: "Beach Cleanup Day",
            organizer: mudraSwari,
            date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
            entryFee: 0,
            locationName: "Sanur Beach",
            latitude: -8.6773,
            longtitude: 115.2618,
            pamphletURL: "image7",
            time: "07:00 - 09:00",
            contactPerson: "+62 123 456 7890",
            desc: "Join our community effort to keep Bali's beaches clean! Gloves, bags, and refreshments provided. Meet at the main entrance to Sanur Beach."
        )
        
        let event14 = Event(
            id: UUID(),
            title: "Bali Cultural Parade",
            organizer: mudraSwari,
            date: Calendar.current.date(byAdding: .day, value: -15, to: Date())!,
            entryFee: 0,
            locationName: "Ubud Main Street",
            latitude: -8.5196,
            longtitude: 115.2632,
            pamphletURL: "image1",
            time: "17:00 - 20:00",
            contactPerson: "+62 812 1234 5678",
            desc: "A festive celebration of Bali's vibrant cultural traditions featuring traditional dance, music, and costume from various regions of the island."
        )
        
        let event15 = Event(
            id: UUID(),
            title: "Full Moon Ceremony",
            organizer: baliSpiritFestival,
            date: Calendar.current.date(byAdding: .day, value: 8, to: Date())!,
            entryFee: 0,
            locationName: "Tirta Empul Temple",
            latitude: -8.4156,
            longtitude: 115.3153,
            pamphletURL: "image2",
            time: "18:00 - 20:00",
            contactPerson: "+62 877 6420 7333",
            desc: "Experience a traditional Balinese full moon ceremony. Visitors are welcome to observe and participate with proper temple attire (sarongs and sashes available for rent)."
        )
        
        context.insert(mudraSwari)
        context.insert(baliSpiritFestival)
        context.insert(kulkul)
        context.insert(omniBali)
        
        context.insert(event1)
        context.insert(event2)
        context.insert(event3)
        context.insert(event4)
        context.insert(event5)
        context.insert(event6)
        context.insert(event7)
        context.insert(event8)
        context.insert(event9)
        context.insert(event10)
        context.insert(event11)
        context.insert(event12)
        context.insert(event13)
        context.insert(event14)
        context.insert(event15)
        
        print("✅ Successfully pre-populated sample data with \(15) events and \(4) organizers")
    }
}
