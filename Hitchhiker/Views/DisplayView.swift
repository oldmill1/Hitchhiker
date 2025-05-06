import SwiftUI

struct DisplayView: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 290)
            .clipped()
            .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    DisplayView(imageName: "headTurnLeftRight")
        .preferredColorScheme(.dark)
}


