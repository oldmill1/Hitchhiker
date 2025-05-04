import SwiftUI

struct DayView: View {
    let day: String
    let movements: [Movement]

    @State private var isPlaying = false
    @State private var currentMovementIndex: Int? = nil
    @State private var timeRemaining: Int = 30
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(white: 0.3), // dark gray
                    Color(white: 0.5), // mid gray
                    Color(white: 0.4)  // soft transition
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()


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
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill") // ▶ or ❚❚
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

                // Current Movement Label
                Text(currentMovementIndex != nil ? movements[currentMovementIndex!].name : "Movement Info")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)

                // Countdown Timer
                Text("\(timeRemaining)")
                    .font(.system(size: 72, weight: .light))
                    .foregroundColor(.white)
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
                .scrollContentBackground(.hidden) // 👈 hides list background
                .background(Color.clear)          // 👈 makes sure background is transparent
                .listStyle(.insetGrouped)

            }
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

