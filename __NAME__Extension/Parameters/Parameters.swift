import AVFoundation
import AUv3Component

/**
 Definitions for the runtime parameters of the DSP kernel.
 */
public final class Parameters: NSObject, ParameterSource {

  /// Array of AUParameter entities created from ParameterAddress value definitions.
  public let parameters: [AUParameter] = __NAME___ParameterAddress.allCases.map {
    $0.parameterDefinition.parameter
  }

  /// Array of 2-tuple values that pair a factory preset name and its definition
  public let factoryPresetValues: [(name: String, preset: Preset)] = [
    (name: "Default", preset: .init(gain: 0.34)),
    (name: "None", preset: .init(gain: 0.0)),
    (name: "Full", preset: .init(gain: 1.0)),
    (name: "Half", preset: .init(gain: 0.5)),
  ]

  /// Array of `AUAudioUnitPreset` values for the factory presets.
  public var factoryPresets: [AUAudioUnitPreset] {
    factoryPresetValues.enumerated().map { .init(number: $0.0, name: $0.1.name ) }
  }

  /// AUParameterTree created with the parameter definitions for the audio unit
  public let parameterTree: AUParameterTree

  /**
   Create a new AUParameterTree for the defined kernel parameters.
   */
  override public init() {
    parameterTree = AUParameterTree.createTree(withChildren: parameters)
    super.init()
    installParameterValueFormatter()
  }
}

/// Provide easy access to the parameter(s) by attribute name
extension ParameterSource {
  /// Obtain the gain parameter
  public var gain: AUParameter { parameters[.gain] }
}

extension Parameters {

  /// Apply a factory preset -- user preset changes are handled by changing AUParameter values through the audio unit's
  /// `fullState` attribute.
  public func useFactoryPreset(_ preset: AUAudioUnitPreset) {
    if preset.number >= 0 {
      setValues(factoryPresetValues[preset.number].preset)
    }
  }

  /**
   Access an AUParameter via its address.

   - parameter address: the address to look for
   - returns: the AUParameter that was found
   */
  public subscript(address: __NAME___ParameterAddress) -> AUParameter {
    parameterTree.parameter(withAddress: address.parameterAddress) ?? missingParameter
  }

  private func installParameterValueFormatter() {
    parameterTree.implementorStringFromValueCallback = { param, valuePtr in
      let value: AUValue
      if let valuePtr = valuePtr {
        value = valuePtr.pointee
      } else {
        value = param.value
      }
      return param.displayValueFormatter(value)
    }
  }

  /**
   Accept new values for the kernel settings. Uses the AUParameterTree framework for communicating the changes to the
   AudioUnit.
   */
  public func setValues(_ preset: Preset) { gain.value = preset.gain }

  private var missingParameter: AUParameter { fatalError() }
}

extension AUParameter: @retroactive AUParameterFormatting {

  /// Obtain string to use to separate a formatted value from its units name
  public var unitSeparator: String { "" }
  public var suffix: String { makeFormattingSuffix(from: unitName) }
  public var stringFormatForDisplayValue: String { "%.2f" }
}

private extension Array where Element == AUParameter {
  subscript(index: __NAME___ParameterAddress) -> AUParameter { self[Int(index.rawValue)] }
}
