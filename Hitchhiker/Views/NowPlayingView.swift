import SwiftUI

struct NowPlayingView: View {
    let currentMovement: Movement?
    let timeRemaining: Int
    let isPlaying: Bool
    let isInPause: Bool
    let onPlayPauseTapped: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            // Left side: control buttons
            HStack(spacing: 16) {
                Button(action: {}) {
                    Image(systemName: "backward.fill")
                }
                .buttonStyle(AquaButtonStyle())

                Button(action: {
                    onPlayPauseTapped()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                }
                .buttonStyle(AquaButtonStyle())

                Button(action: {}) {
                    Image(systemName: "forward.fill")
                }
                .buttonStyle(AquaButtonStyle())
            }
            .padding(.horizontal)

            // Right side: capsule text
            VStack(spacing: 4) {
                Text(isInPause ? "Rest" : (currentMovement?.name ?? "Movement Info"))
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.9),
                        Color.green.opacity(0.4)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(Color.primary.opacity(0.2), lineWidth: 1)
            )
        }
        .frame(height: 80)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.gray.opacity(0.2),
                            Color.gray.opacity(0.05)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}

// MARK: - Aqua-style Button

struct AquaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .bold))
            .frame(width: 36, height: 36)
            .background(
                Circle()
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.4), radius: 2, x: 0, y: 1)
            )
            .foregroundColor(.black)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

// MARK: - Preview

#Preview {
    NowPlayingView(
        currentMovement: Movement(name: "Hitchhiker's Guide", image: "headTurnLeftRight"),
        timeRemaining: 45,
        isPlaying: false,
        isInPause: false,
        onPlayPauseTapped: {
            print("Play/Pause tapped (preview)")
        },
    )
    .preferredColorScheme(.dark) // Try .light or .dark
}
