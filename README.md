# International Clock

International Clock is a native macOS menu bar app for Singapore Time and Pacific Time. It shows the day, date, and time, for example `🇸🇬 Mon Nov 9 8:42 AM`.

Click the menu bar clock to choose **Singapore Time** or **Pacific Time**. The app remembers your choice. Pacific Time follows daylight saving automatically.

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
