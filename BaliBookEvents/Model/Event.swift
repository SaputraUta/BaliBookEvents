import SwiftData
import Foundation

@Model
class Event {
    var id: UUID
    var title: String
    @Relationship var organizer: Organizer?
    var date: Date
    var entryFee: Double
    var locationName: String
    var latitude: Double
    var longtitude: Double
    var pamphletURL: String?
    var time: String
    var contactPerson: String
    var desc: String
    
    init(id: UUID, title: String, organizer: Organizer? = nil, date: Date, entryFee: Double, locationName: String, latitude: Double, longtitude: Double, pamphletURL: String? = nil, time: String, contactPerson: String, desc: String) {
        self.id = id
        self.title = title
        self.organizer = organizer
        self.date = date
        self.entryFee = entryFee
        self.locationName = locationName
        self.latitude = latitude
        self.longtitude = longtitude
        self.pamphletURL = pamphletURL
        self.time = time
        self.contactPerson = contactPerson
        self.desc = desc
    }
}
