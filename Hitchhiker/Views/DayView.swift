import SwiftUI
import AudioToolbox

struct DayView: View {
    let day: String
    let movementSets: [MovementSet]

    @State private var isPlaying = false
    @State private var currentSetIndex: Int = 0
    @State private var currentMovementIndex: Int = 0
    @State private var currentSetRepeat: Int = 1
    @State private var isInPause: Bool = false
    @State private var timeRemaining: Int = 0
    @State private var timer: Timer? = nil
    @State private var hasStarted: Bool = false

    
    @State private var expandedSections: Set<MovementSet.ID> = []

    var currentSet: MovementSet? {
        guard currentSetIndex < movementSets.count else { return nil }
        return movementSets[currentSetIndex]
    }

    var currentMovement: Movement? {
        guard let set = currentSet, currentMovementIndex < set.movements.count else { return nil }
        return set.movements[currentMovementIndex]
    }

    var body: some View {
        
        VStack(spacing: 0) {
            DisplayView(imageName: "headTurnLeftRight")
            if hasStarted {
                NowPlayingView()
                    .padding(.top, -42)
            } else {
                Button(action: {
                    hasStarted = true
                    isPlaying = true

                    if timeRemaining == 0, let set = currentSet {
                        timeRemaining = isInPause ? set.pauseBetween : set.duration
                    }

                    startTimer()
                }) {
                    Text("Start Workout")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding(.horizontal, 36)
                        .padding(.vertical, 14)
                        .background(
                            LinearGradient(
                                colors: [Color.white.opacity(0.9), Color.green.opacity(0.5)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule().stroke(Color.primary.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                .padding(.top, -42)
            }

            Spacer()
        }
        
    }

    // MARK: - Timer Logic

    func startTimer() {
        stopTimer() // always reset the old timer

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 1 {
                timeRemaining -= 1

                if !isInPause && timeRemaining <= 5 {
                    beep()
                }

            } else {
                if !isInPause {
                    doubleBeep()
                }
                advance()
            }
        }
    }


    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func advance() {
        stopTimer()

        guard let set = currentSet else {
            isPlaying = false
            return
        }

        if isInPause {
            // Pause just ended → begin movement
            isInPause = false
            doubleBeep()

            if currentMovementIndex + 1 < set.movements.count {
                currentMovementIndex += 1
            } else {
                if currentSetRepeat < set.repeatCount {
                    currentSetRepeat += 1
                    currentMovementIndex = 0
                } else {
                    currentSetIndex += 1
                    currentSetRepeat = 1
                    currentMovementIndex = 0
                }
            }
        } else {
            // Finished movement → begin pause
            isInPause = true
        }

        // If we’ve gone past the last set, stop playback
        if currentSetIndex >= movementSets.count {
            isPlaying = false
            return
        }

        // Set the new timeRemaining properly
        if let nextSet = currentSet {
            timeRemaining = isInPause ? nextSet.pauseBetween : nextSet.duration
        }

        startTimer()
    }



    // MARK: - Sounds

    func beep() {
        AudioServicesPlaySystemSound(1052)
    }

    func doubleBeep() {
        AudioServicesPlaySystemSound(1052)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            AudioServicesPlaySystemSound(1052)
        }
    }

}

#Preview {
    NavigationView {
        DayView(day: "Monday", movementSets: MovementData.mondaySets)
    }
}

