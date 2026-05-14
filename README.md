# bpmlight - flash to the beat

> 日本語のREADMEはこちらです: [README.ja.md](README.ja.md)

An iOS app that strobes your iPhone's LED flashlight in sync with a specified BPM (Beats Per Minute). Adjust the rate, waveform, and brightness to create custom light patterns.


![bpmlight UI Screenshot](https://user-images.githubusercontent.com/5879/288009231-1e649082-136a-4c2e-836d-109249688448.png)


## Features

-   **BPM Control**: Adjust the flash rate from 0 to 300 BPM using a slider.
-   **Waveform Patterns**:
    -   **Linear**: A sharp, sawtooth wave that ramps brightness from 0% to 100%.
    -   **Sine**: A smooth pulse that fades in and out.
-   **Brightness Control**: Set the peak brightness for the strobe effect. All patterns scale relative to this setting.
-   **Manual Override**: Instantly turn the flashlight fully ON or OFF with dedicated buttons, independent of the BPM timer.
-   **Live Adjustments**: All parameters (BPM, waveform, brightness) can be modified in real-time while the light is flashing.

## Requirements

-   iOS 18.5 or later
-   An iPhone with an LED flashlight

## Installation & Usage

This app is not on the App Store. You will need to build it from source using Xcode.

1.  Clone this repository to your local machine.
2.  Open `bpmlight.xcodeproj` in Xcode.
3.  Connect your iPhone and select it as the build target.
4.  Press the "Run" button in Xcode to build and install the app on your device.

### How to Use the App

1.  **Set BPM**: Use the "BPM" slider to set your desired tempo.
2.  **Choose Waveform**: Tap "Linear" or "Sine" to select the flash pattern.
3.  **Adjust Brightness**: Use the top "brightness" slider to set the maximum intensity of the flash.
4.  **Start Flashing**: Tap the **START** button.
5.  **Stop Flashing**: Tap the **STOP** button.

You can also use the **ON** and **OFF** buttons to use the app as a simple manual flashlight.

## License

MIT License — see [LICENSE](LICENSE).