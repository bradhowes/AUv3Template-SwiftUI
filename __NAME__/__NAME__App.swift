import AUv3Host
import AUv3Shared
import AudioToolbox
import ComposableArchitecture
import SwiftUI

@main
struct __NAME__App: App {

  let config = HostConfig(
    name: Bundle.main.auComponentName,
    version: "1.2.3",
    appStoreId: Bundle.main.appStoreId,
    componentDescription: .init(
      componentType: Bundle.main.auComponentType,
      componentSubType: Bundle.main.auComponentSubtype,
      componentManufacturer: Bundle.main.auComponentManufacturer,
      componentFlags: 0,
      componentFlagsMask: 0
    ),
    sampleLoop: .sample1,
    appStoreVisitor: { _ in },
    maxWait: .seconds(15),
    alwaysShowNotice: false
  )

  var body: some Scene {
    WindowGroup {
      ContentView(config: config)
        .padding(.top, 16)
        .accentColor(config.themeLabelColor)
        .environment(\.themeControlColor, config.themeControlColor)
        .environment(\.themeLabelColor, config.themeLabelColor)
    }
  }
}
