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
    @State private var timeRemaining: Int = 30
    @State private var timer: Timer? = nil

    var currentSet: MovementSet? {
        guard currentSetIndex < movementSets.count else { return nil }
        return movementSets[currentSetIndex]
    }

    var currentMovement: Movement? {
        guard let set = currentSet, currentMovementIndex < set.movements.count else { return nil }
        return set.movements[currentMovementIndex]
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(white: 0.3),
                    Color(white: 0.5),
                    Color(white: 0.4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Play/Pause Button
                Button(action: {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    isPlaying.toggle()

                    if isPlaying {
                        startTimer()
                    } else {
                        stopTimer()
                    }
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 28, weight: .bold))
                        .frame(width: 64, height: 64)
                        .background(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.gray.opacity(0.6), Color.black.opacity(0.8)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 2)
                        .foregroundColor(.white)
                }
                .padding(.top, 16)

                // Album Art Placeholder
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray5))
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                    .padding(.top, 8)

                // Movement label
                Text(isInPause ? "Now resting..." : currentMovement?.name ?? "Movement Info")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 4)

                // Timer label
                Text(isInPause ? "Rest for \(timeRemaining)" : "Move for \(timeRemaining)")
                    .font(.system(size: 28, weight: .medium, design: .monospaced))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)

                // Movement List
                List {
                    ForEach(movementSets) { set in
                        Section(header: Text(set.name).font(.title2).foregroundColor(.white)) {
                            ForEach(set.movements) { movement in
                                HStack {
                                    Text(movement.name)
                                    Spacer()
                                    if movement == currentMovement {
                                        Circle()
                                            .fill(Color.green)
                                            .frame(width: 10, height: 10)
                                    }
                                }
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .listStyle(.insetGrouped)
            }
        }
    }

    // MARK: - Timer Logic

    func startTimer() {
        stopTimer()
        if let set = currentSet {
            timeRemaining = isInPause ? set.pauseBetween : set.duration
        }

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 1 {
                timeRemaining -= 1

                if !isInPause && timeRemaining <= 5 {
                    beep()
                }

            } else {
                // Skip displaying 0
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
            // After pause, either next movement or repeat/set
            isInPause = false

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
            // Finished movement → enter pause
            isInPause = true
        }

        if currentSetIndex >= movementSets.count {
            isPlaying = false
        } else {
            startTimer()
        }
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

