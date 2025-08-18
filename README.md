[![][swift6]](https://swift.org)
[![AUv3][auv3]][au]
[![License: MIT][mit]][license]

![](media/256px.png)

# About AUv3Template2

This is full-featured AUv3 effect template for both iOS and macOS platforms. When configured, it will build an app for
macOS and iOS platforms and embed in the app bundle an app extension containing the AUv3 component. The apps are
designed to load the AUv3 component the same way as a host such as GarageBand would. It uses the extension to
demonstrate how it works by playing a sample audio file and routing it through the effect and out to the device's
speaker. The host app also supports user and factory presets. User presets can be created, updated, renamed and deleted.
Factory presets can only be activated.

Additional features and info:

* Uses a C++ kernel to generate audio samples in the render thread
* Relies on Swift-C++ interoperability for access to the kernel from Swift code
* Uses SwiftUI for all user interfaces

Also see my older version [AUv3Template](https://github.com/bradhowes/AUv3Template) that uses UIKit and AppKit for UI rendering.

## Host Controls

The controls at the top come from the AUv3Host package as part of the host application infrastructure it provides.
There, you find:

- _play_ button to start/stop audio playing through the filter
- _bypass_ button to disable the filter
- _presets bar_ to quickly choose from a factory preset from the AUv3 extension
- _presets menu_ to show a menu of user and factory presets

The hosting app supports creating and managing user presets for the extension. These should operate in the same way that
they do in other hosting apps such as GarageBand, Logic, Cubasis, AUM. When a user preset is active, you can then:

- _Update_ the preset by saving the current parameter settings under its name
- _Rename_ the preset to give it a new name
- _Delete_ the preset to remove it from the device

# Swift 6

The code was originally developed in Xcode 12.4 on macOS 11.2.1 but the latest version now requires Swift 6. There are
currently no known concurrency warnings or errors in the code.

Apps from the template have tested on both macOS and iOS devices, primarily in GarageBand but also using test hosts on
both devices as well as the excellent [AUM][aum] app on iOS.

Finally, it passes all [auval][auval] tests:

```bash
% auval -v aufx flng BRay
```

Here `flng` is the unique component subtype for my [SimplyFlange](https://github.com/bradhowes/SimplyFlange) effect and
`BRay` is my own manufacturer ID. You should use your own values that you put in [Config.xcconfig][cfg].

# Generating a New AUv3 Project

Note that this repo **is** a template, and as such it may not successfully run when compiled. The best bet is to use the
Python3 [build.py](scripts/build.py) script to create a new project from the template. To do so, fire up a terminal
shell and go into the _AUV3Template_ directory. The script takes two arguments:

- the name of the new project
- the 4-character _subtype_ of the effect

You would run it like this:

```bash
% python3 scripts/build.py MyEffect subtype
```

The name value should be self-evident in purpose: it will be the name of your iOS and macOS app, and the basis for the
name of your app extensions. The _subtype_ is a unique 4-character identifier for your new effect. It should be unique
at least for your manufacturer space (see [Config.xcconfig][cfg]) so that it will not conflict with another app
extension.

With a project name called "MyEffect", the Python3 script will creates new folder called _MyEffect_ that is a sibling to
the _AUv3Template2_ folder. The script will populate the new folder with the files from this template. Afterwards you
should have a buildable and working AUv3 effect embedded in a demo app for iOS and macOS. All files with `__NAME__` in
them will be replaced with the first argument given to `build.py` (e.g. "MyEffect"), and all text files will be changed
so that the strings `__NAME__` and `__SUBTYPE__` are replaced with their respective substitutions that you provided.

Note that to successfully compile you will need to edit [Config.xcconfig][cfg] and change the
`DEVELOPMENT_TEAM` setting to hold your own Apple developer account ID so that Xcode can sign the binaries it creates.
You should also adjust other settings as well to properly identify you and/or your company. The values to change should
be clear.

> :warning: You are free to use the code according to [LICENSE.md](LICENSE.md), but you must not replicate
> someone's UI, icons, samples, or any other assets if you are going to distribute your effect on the App Store.

# Dependencies

This code currently depends on three other Swift packages:

- [auv3-support](https://github.com/bradhowes/auv3-support) -- common AUv3 component and host code.
- [AUv3Controls](https://github.com/bradhowes/AUv3Controls) -- knob and switch controls in SwiftUI
- [DSPHeaders](https://github.com/bradhowes/AUv3Controls) -- C++ v23 header files for DSP processing

[ci]: https://github.com/bradhowes/AUv3Template-SwiftUI/actions/workflows/CI.yml
[status]: https://github.com/bradhowes/AUv3Template-SwiftUI/actions/workflows/CI.yml/badge.svg?branch=main
[swift6]: https://img.shields.io/badge/Swift-6-orange.svg?style=flat
[auv3]: https://img.shields.io/badge/AudioUnit-AUv3-orange.svg
[au]: https://developer.apple.com/documentation/audiounit
[mit]: https://img.shields.io/badge/License-MIT-A31F34.svg
[license]: https://opensource.org/licenses/MIT
[cfg]: Config.xcconfig
[aum]: https://apps.apple.com/us/app/aum-audio-mixer/id1055636344
[auval]: https://developer.apple.com/library/archive/documentation/MusicAudio/Conceptual/AudioUnitProgrammingGuide/AudioUnitDevelopmentFundamentals/AudioUnitDevelopmentFundamentals.html
