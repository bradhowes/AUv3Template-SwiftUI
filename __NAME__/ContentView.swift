import AUv3Host
import ComposableArchitecture
import SwiftUI

struct ContentView: View {
  let config: HostConfig

  var body: some View {
    HostView(store: StoreOf<HostFeature>(initialState: .init(config: config)) { HostFeature() } )
  }
}

#Preview {
  let config = HostConfig(
    name: "Skippy",
    version: "1.2.3",
    appStoreId: "1554960150",
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
    alwaysShowNotice: true
  )
  ContentView(config: config)
    .environment(\.tintColor, config.themeLabelColor)
    .environment(\.themeControlColor, config.themeControlColor)
    .environment(\.themeLabelColor, config.themeLabelColor)
}
