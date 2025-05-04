// DayView.swift

import SwiftUI

struct DayView: View {
    let day: String
    let movements: [Movement]

    var body: some View {
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

#Preview {
    NavigationView {
        DayView(day: "Monday", movements: MovementData.mondayMovements)
    }
}
