import SwiftUI

struct DayView: View {
    let day: String
    let movements: [Movement]

    @State private var isPlaying = false

    var body: some View {
        VStack(spacing: 0) {
            // Play/Pause Button
            Button(action: {
                isPlaying.toggle()
            }) {
                Text(isPlaying ? "Pause" : "Play")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isPlaying ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding([.horizontal, .top])
            }

            // Album Art Placeholder (Black Square)
            Rectangle()
                .fill(Color.black)
                .aspectRatio(1, contentMode: .fit) // ensures it's square
                .frame(maxWidth: .infinity)
                .padding(.top, 8)

            // Centered Label
            Text("Movement Info")
                .font(.title2) // ← increased size from .subheadline
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)
            
            // Countdown Label
            Text("30")
                .font(.system(size: 72, weight: .light))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)


            // Movement List
            List {
                Section(header: Text(day.capitalized).font(.largeTitle)) {
                    ForEach(movements) { movement in
                        Text(movement.name)
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    NavigationView {
        DayView(day: "Monday", movements: MovementData.mondayMovements)
    }
}

