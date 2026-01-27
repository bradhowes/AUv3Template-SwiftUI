import AUv3Controls
import ComposableArchitecture
import SwiftUI

struct AUMainView: View {
  let gainStore: StoreOf<KnobFeature>
  let topKnobWidth: CGFloat = 160

  @Environment(\.colorScheme) private var colorScheme

  init(gain: AUParameter) {
    self.gainStore = Store(initialState: KnobFeature.State(parameter: gain)) {
      KnobFeature()
    }
  }

  var body: some View {
    Group {
      VStack {
        KnobView(store: gainStore)
          .frame(maxWidth: topKnobWidth)
          .preferredColorScheme(.dark)
      }
      .knobValueEditor()
      .auv3ControlsTheme(Theme(colorScheme: colorScheme))
    }
    .environment(\.colorScheme, .dark)
  }
}
