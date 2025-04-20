import SwiftData
import Foundation

@Model
class Organizer {
    var id: UUID
    var name: String
    var contactPerson: String
    var websiteURL: String?
    var desc: String
    var jargon: String
    var pastEventPhotoURLs: [String]
    
    @Relationship(inverse: \Event.organizer) var events: [Event]
    
    init(id: UUID, name: String, contactPerson: String, websiteURL: String? = nil, desc: String, jargon: String, pastEventPhotoURLs: [String]) {
        self.id = id
        self.name = name
        self.contactPerson = contactPerson
        self.websiteURL = websiteURL
        self.desc = desc
        self.jargon = jargon
        self.events = []
        self.pastEventPhotoURLs = pastEventPhotoURLs
    }
}
