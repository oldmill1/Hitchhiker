import SwiftUI

struct ControlsView: View {
    let currentMovement: Movement?
    let isInPause: Bool
    let timeRemaining: Int
    let isPlaying: Bool
    let onPlayPauseTapped: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            // Movement Label
            Text(isInPause ? "Now resting..." : currentMovement?.name ?? "Movement Info")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.primary)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .shadow(radius: 4, y: 2)

            // Timer Label
            Group {
                if timeRemaining > 0 {
                    Text(isInPause ? "Rest for \(timeRemaining)" : "Move for \(timeRemaining)")
                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                        .foregroundColor(.primary)
                } else {
                    Text("Ready?")
                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(radius: 4, y: 2)

            // Play/Pause Button
            Button(action: {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                onPlayPauseTapped()
            }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 28, weight: .bold))
                    .frame(width: 64, height: 64)
                    .background(
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.gray.opacity(0.5),
                                        Color.primary.opacity(0.3)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.primary.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(radius: 4, y: 2)
                    .foregroundColor(.primary)
            }
        }
        .padding(.bottom, 16)
    }
}

#Preview {
    ControlsView(
        currentMovement: Movement(name: "Mountain Climbers"),
        isInPause: false,
        timeRemaining: 45,
        isPlaying: false,
        onPlayPauseTapped: {}
    )
    .padding()
    .background(Color(.systemBackground))
    .preferredColorScheme(.light)
}
