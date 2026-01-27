import AUv3Host
import AUv3Shared
import AudioToolbox
import ComposableArchitecture
import SwiftUI

@main
struct __NAME__App: App {
#if os(macOS)
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif

  let config = HostConfig(
    name: Bundle.main.auComponentName,
    version: Bundle.main.versionTag,
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
    HostScene(config: config, store: StoreOf<HostFeature>(initialState: .init(config: config)) { HostFeature() })
  }
}

#if os(macOS)
class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}
#endif // os(macOS)
