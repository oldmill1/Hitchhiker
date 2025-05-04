// HitchhikerApp.swift

import SwiftUI

@main
struct HitchhikerApp: App {
    var body: some Scene {
        WindowGroup {
            HomepageView()
        }
    }
}

#if DEBUG
struct HitchhikerApp_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
#endif

