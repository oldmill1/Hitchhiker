// MovementData.swift

import Foundation

struct MovementData {
    // Movements used across sets
    static let mountainClimbers = Movement(name: "Mountain Climbers")
    static let bicycleCrunch = Movement(name: "Bicycle Crunch")
    static let reverseCrunch = Movement(name: "Reverse Crunch")
    static let sidePlankDip = Movement(name: "Side Plank Dip")
    static let burpee = Movement(name: "Burpee")
    static let kettlebellSwing = Movement(name: "Kettlebell Swing")
    static let russianTwists = Movement(name: "Russian Twists")
    static let plankUpDown = Movement(name: "Plank Up Down")
    static let flutterKick = Movement(name: "Flutter Kick")
    static let crunches = Movement(name: "Crunches")
    static let special = Movement(name: "Special")

    static let warmupMovements = [
        Movement(name: "Head Turns (Up Down)", image: "headTurnLeftRight"),
        Movement(name: "Head Turns (Left Right)" , image: "headTurnLeftRight"),
        Movement(name: "Foot Circles (Left Foot)", image: "footCircles"),
        Movement(name: "Foot Circles (Right Foot)", image: "footCircles"),
        Movement(name: "Shoulder Rotations", image: "shoulderRotations"),
        Movement(name: "Lateral Side Bends"),
        Movement(name: "Prisoner Squats"),
        Movement(name: "Reverse Lunges"),
        Movement(name: "Plank Walkouts"),
        Movement(name: "High Knees"),
        Movement(name: "Side Skater"),
        Movement(name: "Child's Pose"),
        Movement(name: "Crescent Knees"),
        Movement(name: "Slow Mountain Climbers"),
        Movement(name: "Plank")
    ]

    static let workoutMovements = [
        mountainClimbers,
        bicycleCrunch,
        reverseCrunch,
        sidePlankDip,
        burpee,
        kettlebellSwing,
        russianTwists,
        plankUpDown,
        flutterKick,
        crunches,
        special
    ]

    static let mondaySets: [MovementSet] = [
        MovementSet(
            name: "Warmup",
            repeatCount: 1,
            duration: 20,
            restTimer: 5,
            movements: warmupMovements
        ),
        MovementSet(
            name: "Workout",
            repeatCount: 3,
            duration: 45,
            restTimer: 5,
            movements: workoutMovements
        )
    ]
}
