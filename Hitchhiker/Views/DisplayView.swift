import SwiftUI

struct DisplayView: View {
    var body: some View {
        Image("headTurnLeftRight")
            .resizable()
            .aspectRatio(contentMode: .fill) // use `.fill` to stretch width
            .frame(height: 290)
            .clipped() // trims overflow to prevent distortion
            .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    DisplayView()
        .preferredColorScheme(.dark)
}


