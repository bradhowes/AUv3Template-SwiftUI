import AudioToolbox

/**
 Collection of values for the parameters of the audio unit. Treated as a unit that can be named and recalled using the
 AUv3 APIs.
 */
public struct Preset {
  public let gain: AUValue

  /**
   Define a new configuration.

   - parameter gain: gain
   */
  public init(gain: AUValue) {
    self.gain = gain
  }
}
