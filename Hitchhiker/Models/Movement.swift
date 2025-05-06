// Movement.swift

import Foundation

struct Movement: Identifiable, Hashable {
    let id: UUID
    let name: String
    let image: String?

    init(name: String, image: String? = nil) {
        self.id = UUID()
        self.name = name
        self.image = image
    }
}


struct MovementSet: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let repeatCount: Int
    let duration: Int          // seconds per movement
    let pauseBetween: Int      // seconds between movements
    let movements: [Movement]
}
