## macOS SwiftUI App - NOW NOT DECIDE

This folder contains Swift source files for a macOS SwiftUI app that implements the following behavior (as requested in Japanese):

- The first screen shows only the text `今決めたい感覚を、一つだけかんじる`.
- There is no "開始" (Start) button; the flow starts automatically when the first screen appears.
- After a specified duration, the app transitions to a `NOW NOT DECIDE` screen.
- On the `NOW NOT DECIDE` screen:
  - It shows `NOW NOT DECIDE` as a title.
  - It shows the text split across two lines:
    - `言葉が出たら`
    - `「今は使わないと」一回だけ`
  - Pressing the `閉じる` button terminates the macOS app.

### Files

- `TimerSwiftApp.swift`  
  The `@main` entry point for the SwiftUI macOS app.

- `ContentView.swift`  
  The first screen that displays the text  
  `今決めたい感覚を、一つだけかんじる`  
  and starts the flow automatically on appear, transitioning to `NowNotDecideView` after a delay.

- `NowNotDecideView.swift`  
  The `NOW NOT DECIDE` screen with the requested Japanese text and a `閉じる` button that calls `NSApplication.shared.terminate(nil)` to quit the app.

### How to run

**You need:** a Mac with **Xcode** installed (from the Mac App Store).

#### Option A: Create a new Xcode project and add these files

1. Open **Xcode** on your Mac.
2. **File → New → Project…**
3. Choose **macOS** → **App** → Next.
4. Set **Product Name** (e.g. `NOW NOT DECIDE`), **Interface**: SwiftUI, **Language**: Swift → Next → choose a folder → Create.
5. In the project navigator:
   - Replace the contents of the generated **App** file with `TimerSwiftApp.swift`.
   - Replace **ContentView.swift** with this repo’s `ContentView.swift`.
   - **File → Add Files to “[Project]”…** and add `NowNotDecideView.swift`.
6. Press **⌘R** (or click the Run button) to build and run. The app window opens on your Mac.

#### Option B: Open this folder in Xcode (if you have an .xcodeproj)

If someone gives you an `.xcodeproj` in this folder, double‑click it to open in Xcode, then press **⌘R** to run.

---

**Note:** The first screen auto-starts and switches to the “NOW NOT DECIDE” screen after 3 minutes (180 seconds). To test faster, change `autoTransitionDuration` in `ContentView.swift` to a smaller value (e.g. `5`).
