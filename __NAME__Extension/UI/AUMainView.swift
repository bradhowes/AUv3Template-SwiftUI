import AUv3Controls
import ComposableArchitecture
import SwiftUI

/**
 The SwiftUI view for the audio unit controls.
 */
struct AUMainView: View {
  let gainStore: StoreOf<KnobFeature>
  let knobWidth: CGFloat = 160
  @Environment(\.colorScheme) var colorScheme

  init(gain: AUParameter) {
    self.gainStore = Store(initialState: KnobFeature.State(parameter: gain)) { KnobFeature() }
  }

  var body: some View {
    Group {
      VStack {
        KnobView(store: gainStore)
          .frame(maxWidth: knobWidth)
      }
      .knobValueEditor()
      .auv3ControlsTheme(Theme(colorScheme: colorScheme))
    }
  }
}
