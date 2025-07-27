# AUv3 Template App

This project showcases the [auv3-support](..) package: it generates an app for iOS and macOS that, when run, makes
available the app extension (_appex_) that is bundled with the host app. The host app simply provides a way to
demonstrate the functionality of the AUv3 appex. The host shows the SwiftUI view of the appex along with some host
controls that interact with the appex.

# Configuration

All AUv3 appex components have a unique combination of three values:

- manufacturer -- the 4-byte code of the producer of the appex
- type -- the AUv3 component type ('aufx' for effects)
- subtype -- the unique code assigned by the manufacturer for the component

These values are stored in the [Config.xcconfig](Config.xcconfig) file and are injected into the Info.plist files for
both the app and the app extension automatically by the build process. They are also available in code by by accessing
the right `Bundle` -- see the [Bundle extensions](../Sources/AUv3Shared/Bundle.swift) for details.

# Host App
