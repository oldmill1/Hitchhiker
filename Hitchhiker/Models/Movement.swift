// Movement.swift

import Foundation

struct Movement: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

struct MovementSet: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let repeatCount: Int
    let duration: Int          // seconds per movement
    let pauseBetween: Int      // seconds between movements
    let movements: [Movement]
}
