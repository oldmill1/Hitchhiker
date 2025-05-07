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
    let duration: Int           // seconds per movement
    let restTimer: Int          // seconds of rest between movements
    let movements: [Movement]
}
