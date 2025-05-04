// WorkoutData.swift

import Foundation

struct MovementData {
    static let mountainClimbers = Movement(name: "Mountain Climbers")
    static let bicycleCrunch = Movement(name: "Bicycle Crunch")
    static let reverseCrunch = Movement(name: "Reverse Crunch")

    static let mondayMovements: [Movement] = [
        mountainClimbers,
        bicycleCrunch,
        reverseCrunch
    ]
}

