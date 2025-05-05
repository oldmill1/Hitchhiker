import SwiftUI

struct ControlsView: View {
    let currentMovement: Movement?
    let isInPause: Bool
    let timeRemaining: Int
    let isPlaying: Bool
    let onPlayPauseTapped: () -> Void

    var backgroundColor: Color {
        isInPause ? Color(red: 1.0, green: 0.85, blue: 0.85) : Color(red: 0.85, green: 1.0, blue: 0.85)
    }

    var body: some View {
        HStack(spacing: 0) {
            // Timer block
            Text("\(timeRemaining)")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .frame(width: 80, height: 80)
                .background(backgroundColor)
                .foregroundColor(.black)
                .cornerRadius(12)

            // Movement name block
            Text(currentMovement?.name ?? "Movement Info")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            // Play/Pause Button
            Button(action: {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                onPlayPauseTapped()
            }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 48, height: 48)
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
            .padding(.trailing, 12)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground).opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(radius: 4)
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
    .preferredColorScheme(.light)
    .padding()
}

