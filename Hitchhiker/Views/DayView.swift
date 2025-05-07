import SwiftUI
import AudioToolbox

struct DayView: View {
    let day: String
    let movementSets: [MovementSet]

    @State private var isPlaying = false
    @State private var currentSetIndex: Int = 0
    @State private var currentMovementIndex: Int = 0
    @State private var currentSetRepeat: Int = 1
    @State private var isInRest: Bool = false
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
            DisplayView(imageName: hasStarted ? (currentMovement?.image ?? "start") : "start")

            if hasStarted {
                NowPlayingView(
                    currentMovement: currentMovement,
                    timeRemaining: timeRemaining,
                    isPlaying: isPlaying,
                    isInRest: isInRest,
                    onPlayPauseTapped: {
                        isPlaying.toggle()

                        if isPlaying {
                            if timeRemaining == 0, let set = currentSet {
                                timeRemaining = isInRest ? set.restTimer : set.duration
                            }
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    }
                )
                .padding(.top, 20)
                
                if isInRest, let next = nextMovement {
                    VStack(spacing: 6) {
                        Text("Next Movement")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.gray)
                            .textCase(.uppercase)
                            .kerning(1.2)

                        Text(next.name)
                            .font(.system(size: 36, weight: .heavy, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.primary)
                            .padding(.horizontal)
                    }
                    .padding(.top, 30)
                } else if let current = currentMovement {
                    VStack(spacing: 6) {
                        Text("Current Movement")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.gray)
                            .textCase(.uppercase)
                            .kerning(1.2)

                        Text(current.name)
                            .font(.system(size: 36, weight: .heavy, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.primary)
                            .padding(.horizontal)
                    }
                    .padding(.top, 30)
                }
            } else {
                Button(action: {
                    hasStarted = true
                    isPlaying = true

                    if timeRemaining == 0, let set = currentSet {
                        timeRemaining = isInRest ? set.restTimer : set.duration
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
                .padding(.top, 20)
            }

            Spacer()
        }
    }

    // MARK: - Timer Logic

    func startTimer() {
        stopTimer()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 1 {
                timeRemaining -= 1

                if !isInRest && timeRemaining <= 5 {
                    beep()
                }

            } else {
                if !isInRest {
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

        if isInRest {
            // Rest just ended → begin movement
            isInRest = false
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
            // Finished movement → begin rest
            isInRest = true
        }

        if currentSetIndex >= movementSets.count {
            isPlaying = false
            return
        }

        if let nextSet = currentSet {
            timeRemaining = isInRest ? nextSet.restTimer : nextSet.duration
        }

        startTimer()
    }
    
    var nextMovement: Movement? {
        guard let set = currentSet else { return nil }

        if currentMovementIndex + 1 < set.movements.count {
            return set.movements[currentMovementIndex + 1]
        } else if currentSetRepeat < set.repeatCount {
            return set.movements.first
        } else if currentSetIndex + 1 < movementSets.count {
            return movementSets[currentSetIndex + 1].movements.first
        }

        return nil
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
    }
}
