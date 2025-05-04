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
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 12) // 👈 extra bottom space
            }


            // Album Art Placeholder (Black Square)
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black)
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4) // 👈 subtle shadow
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

