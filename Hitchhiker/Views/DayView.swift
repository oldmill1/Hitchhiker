import SwiftUI

struct DayView: View {
    let day: String
    let movements: [Movement]

    @State private var isPlaying = false
    @State private var currentMovementIndex: Int? = nil
    @State private var timeRemaining: Int = 30
    @State private var timer: Timer? = nil

    var body: some View {
        VStack(spacing: 0) {
            // Play/Pause Button
            Button(action: {
                isPlaying.toggle()

                if isPlaying {
                    if currentMovementIndex == nil {
                        currentMovementIndex = 0
                        timeRemaining = 30
                    }
                    startTimer()
                } else {
                    stopTimer()
                }
            }) {
                Text(isPlaying ? "Pause" : "Play")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isPlaying ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 12)
            }

            // Album Art Placeholder
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray5))
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                .padding(.top, 8)

            // Current Movement Label
            Text(currentMovementIndex != nil ? movements[currentMovementIndex!].name : "Movement Info")
                .font(.title2)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)

            // Countdown Timer
            Text("\(timeRemaining)")
                .font(.system(size: 72, weight: .light))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)

            // Movement List
            List {
                Section(header: Text(day.capitalized).font(.largeTitle)) {
                    ForEach(movements.indices, id: \.self) { index in
                        HStack {
                            Text(movements[index].name)
                            Spacer()
                            if currentMovementIndex == index {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 10, height: 10)
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }

    // MARK: - Timer Logic

    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                advanceToNextMovement()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func advanceToNextMovement() {
        guard let index = currentMovementIndex else { return }

        let nextIndex = index + 1
        if nextIndex < movements.count {
            currentMovementIndex = nextIndex
            timeRemaining = 30
        } else {
            stopTimer()
            isPlaying = false
            currentMovementIndex = nil
        }
    }
}

#Preview {
    NavigationView {
        DayView(day: "Monday", movements: MovementData.mondayMovements)
    }
}

