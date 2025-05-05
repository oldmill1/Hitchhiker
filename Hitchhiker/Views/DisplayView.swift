import SwiftUI

struct DisplayView: View {
    var body: some View {
        Image("headTurnLeftRight")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
            .padding(.top, 61)
            .offset(x: -40)
            .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    DisplayView()
        .preferredColorScheme(.dark)
}


