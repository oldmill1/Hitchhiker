// DayView.swift

import SwiftUI

struct DayView: View {
    let day: String
    let movements: [Movement]

    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                // Play button action goes here
                print("Play tapped")
            }) {
                Text("Play")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding([.horizontal, .top])
            }

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

