import AUv3Controls
import ComposableArchitecture
import SwiftUI

struct AUMainView: View {
  let gainStore: StoreOf<KnobFeature>
  let topKnobWidth: CGFloat = 160

  init(gain: AUParameter) {
    self.gainStore = Store(initialState: KnobFeature.State(parameter: gain)) {
      KnobFeature(parameter: gain)
    }
  }

  var body: some View {
    Group {
      VStack {
        KnobView(store: gainStore)
          .frame(maxWidth: topKnobWidth)
          .preferredColorScheme(.dark)
      }
      .knobNativeValueEditorHost()
    }
    .environment(\.colorScheme, .dark)
  }
}
