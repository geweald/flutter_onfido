# flutter_onfido

Onfido SDK flutter plugin.
Inspired and based on Onfido [react-native-sdk](https://github.com/onfido/react-native-sdk)

Android SDK: `9.3.1`

iOS SDK: `23.0`

## Project adjustments

### Android

Enable multidex in `android/app/build.gradle`:

```gradle
android {
  defaultConfig {
    ...
    multiDexEnabled true
  }
}
```

### iOS

Update your iOS configuration files

Change `ios/Podfile` to use version 10:

```ruby
platform :ios, '10.0'
```

Add descriptions for camera and microphone permissions to `ios/YourProjectName/Info.plist`:

```xml
<plist version="1.0">
<dict>
  <!-- Add these four elements: -->
    <key>NSCameraUsageDescription</key>
    <string>Required for document and facial capture</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Required for video capture</string>
  <!-- ... -->
</dict>
</plist>
```

## Usage

```dart
 var result = await FlutterOnfido.start(
    config: OnfidoConfig(
        sdkToken: "SDK_TOKEN_JWT",
        flowSteps: OnfidoFlowSteps(
            welcome: false,
            captureDocument: OnfidoCaptureDocumentStep(countryCode: OnfidoCountryCode.USA, docType: OnfidoDocumentType.GENERIC),
            captureFace: OnfidoCaptureFaceStep(OnfidoCaptureType.PHOTO),
        ),
    ),
    iosAppearance: OnfidoIOSAppearance(),
);
```

**Parameters details**:

- **`sdkToken`**: Required. This is the JWT sdk token obtained by making a call to the SDK token API.
- **`flowSteps`**: Required. This object is used to toggle individual screens on and off and set configurations inside the screens.

**Flow steps**:

- **`welcome`**: Optional. This toggles the welcome screen on or off. If omitted, this screen does not appear in the flow.
- **`captureDocument`**: Optional. This object contains configuration for the capture document screen. If docType and countryCode are not specified, a screen will appear allowing the user to choose these values. If omitted, this screen does not appear in the flow.
- **`docType`**: Required if countryCode is specified.
  **Note**: `GENERIC` document type doesn't offer an optimised capture experience for a desired document type.
- **`countryCode`**: Required if docType is specified.
- **`captureFace`**: Optional. This object object containing options for capture face screen. If omitted, this screen does not appear in the flow.
- **`type`**: Required if captureFace is specified.

## Theme

For **iOS** theme config use `OnfidoAppearance` class and its properties.

For **Android** in order to enhance the user experience on the transition between your application and the SDK, you can provide some customization by defining certain colors inside your own `colors.xml` file inside `android` folder and project:

- `onfidoColorPrimary`: Defines the background color of the `Toolbar` which guides the user through the flow

- `onfidoColorPrimaryDark`: Defines the color of the status bar above the `Toolbar`

- `onfidoTextColorPrimary`: Defines the color of the title on the `Toolbar`

- `onfidoTextColorSecondary`: Defines the color of the subtitle on the `Toolbar`

- `onfidoColorAccent`: Defines the color of the `FloatingActionButton` which allows the user to move between steps, as well as some details on the
  alert dialogs shown during the flow

- `onfidoPrimaryButtonColor`: Defines the background color of the primary action buttons (e.g. proceed to the next flow step, confirm picture/video, etc),
  the color of the text on the secondary action buttons (e.g. retake picture/video) and the background color of some icons and markers during the flow

- `onfidoPrimaryButtonColorPressed`: Defines the background color of the primary action buttons when pressed

- `onfidoPrimaryButtonTextColor`: Defines the color of the text inside the primary action buttons

## Contributions

Inspired and based on Onfido [react-native-sdk](https://github.com/onfido/react-native-sdk). Java has been changed to kotlin which I don't know well so code may be improved. **I won't maintain this package very frequently, feel free to contribute!** Some action points:

**TODO**:

- [ ] - localization support
- [ ] - add support for hide logo and cobranding enterprise features
- [ ] - better example project
- [ ] - tests
- [ ] - improve docs
- [ ] - improve kotlin code

## Getting Started with Flutter plugins

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
