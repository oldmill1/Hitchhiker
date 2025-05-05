import SwiftUI

struct PlaylistView: View {
    let movementSets: [MovementSet]
    let currentMovement: Movement?
    let expandedSections: Set<MovementSet.ID>
    let onToggleSection: (MovementSet.ID) -> Void
    let onSelectMovement: (MovementSet.ID, Int) -> Void

    var body: some View {
        List {
            ForEach(movementSets) { set in
                Section(header: Text(set.name)) {
                    ForEach(Array(set.movements.enumerated()), id: \.element.id) { index, movement in
                        HStack {
                            Text(movement.name)
                            Spacer()
                            if movement == currentMovement {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            onSelectMovement(set.id, index)
                        }
                    }
                }
            }
        }
    }
}



#Preview {
    PlaylistView(
        movementSets: MovementData.mondaySets,
        currentMovement: MovementData.mondaySets.first?.movements.first,
        expandedSections: [],
        onToggleSection: { _ in },
        onSelectMovement: { _, _ in }
    )
}


