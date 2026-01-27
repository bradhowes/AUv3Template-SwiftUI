import AUv3Component
import AUv3Shared
import Combine
import CoreAudioKit
import os
import SwiftUI

/**
 Custom factory for creating the AUv3 SwifUI view for the audio unit kernel.
 */
@MainActor
struct ViewControllerFactory: HostingControllerFactory {

  /**
   Custom factory for creating the SwiftUI view of the audio unit. Satisfies the `HostingControllerFactory` requirement.

   - parameter audioUnit: the audio unit to install
   - returns: the view controller that is hosting the SwiftUI view of the audio unit
   */
  static func make(audioUnit: AudioUnitAdapter) -> AUv3HostingController<AUMainView> {
    guard let parameterTree = audioUnit.parameterTree,
          let gain = parameterTree.parameter(withAddress: __NAME___ParameterAddress.gain.rawValue)
    else {
      fatalError("failed to get gain parameter")
    }
    return .init(rootView: .init(gain: gain))
  }
}

/**
 View controller for the AUv3 view. NOTE: this class name *must* match the value found in the `Factory Function` element
 in the AUv3 Info.plist definition. If not, the AUv3 will not render.
 */
@MainActor
class AudioUnitViewController: AudioUnitViewControllerBase<ViewControllerFactory>, AUAudioUnitFactory {

  /**
   Entry point for creating a new AUv3 component. Satisfies `AUAudioUnitFactory` protocol requirement.

   - parameter componentDescription: specification of the AUv3 component to create
   - returns: new AUAudioUnit instance
   */
  nonisolated public func createAudioUnit(with componentDescription: AudioComponentDescription) throws -> AUAudioUnit {
    let bundle = Bundle(for: Self.self)
    return installAudioUnit(
      try AudioUnitAdapterFactory.create(
        componentDescription: componentDescription,
        parameters: Parameters(),
        kernel: __NAME___Kernel.make(std.string(bundle.auBaseName)),
        viewConfigurationManager: self
      )
    )
  }
}

extension AudioUnitViewController: AudioUnitViewConfigurationManager {}
extension __NAME___Kernel: AudioRenderer {}
