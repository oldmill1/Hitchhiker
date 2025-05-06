import SwiftUI

struct HomepageView: View {
    private let daysOfWeek = [
        "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday", "Sunday"
    ]

    var body: some View {
        NavigationView {
            List(daysOfWeek, id: \.self) { day in
                NavigationLink(
                    destination: DayView(
                        day: day,
                        movementSets: day == "Monday" ? MovementData.mondaySets : []
                    )
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                ) {
                    Text(day)
                }
            }
            .navigationTitle("Workout Days")
        }
    }
}

#Preview {
    HomepageView()
}
