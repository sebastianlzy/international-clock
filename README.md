# International Clock

International Clock is a native macOS menu bar app that shows the day, date, and time in your selected time zone.

![International Clock showing Singapore Time in the macOS menu bar](menu-bar.png)

The app currently supports two time zones. Click the menu bar clock to switch between them.

- 🇸🇬 **Singapore Time (SGT)**
- 🇺🇸 **Pacific Time (PT)**, which follows daylight saving automatically

The app remembers your choice.

## Build and run

1. Use macOS 13 or later. Install Apple's Command Line Tools if needed:

   ```sh
   xcode-select --install
   ```

2. Clone this repository and open its directory in Terminal.
3. Build and open the app:

   ```sh
   sh build.sh
   open "International Clock.app"
   ```

The build script compiles the Swift source and signs the app locally. To close it, click the clock and choose **Quit International Clock**.

## Contributing

Pull requests that add support for more time zones are welcome.
